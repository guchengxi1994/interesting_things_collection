use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub enum IpcMessage {
    LabelMessage(String),
}

slint::slint! {
    import { Button , HorizontalBox, VerticalBox} from "std-widgets.slint";
    export component Dialog inherits Window {
        title: "对话框";
        width: 300px;
        height: 200px;
        no-frame: true;
        icon: @image-url("icon.png");

        Rectangle {
            background: @linear-gradient (90deg, #cde4ee 0%, #ebf8e1 100%);
        }

        callback close-dialog();

        VerticalBox {
            Text {
                text: "对话框";
                color: green;
            }
            Button {
                text: "返回数据并关闭";
                width: 120px;
                height: 40px;
                clicked => {
                    close-dialog()
                }
            }
        }
    }
}

fn show_dialog_x(ipc_server_name: String) -> anyhow::Result<()> {
    let dialog = Dialog::new()?;
    dialog
        .window()
        .set_position(slint::PhysicalPosition::new(0, 0));
    let dialog_handle = dialog.as_weak();
    dialog.on_close_dialog(move || {
        let server_name = ipc_server_name.clone();
        // 给主窗口返回数据
        let tx: ipc_channel::ipc::IpcSender<IpcMessage> =
            ipc_channel::ipc::IpcSender::connect(server_name).unwrap();
        tx.send(IpcMessage::LabelMessage("数据更新成功!".to_string()))
            .unwrap();
        dialog_handle.unwrap().hide().unwrap();
    });

    dialog.run()?;

    anyhow::Ok(())
}

#[allow(unused_imports)]
mod tests {
    use crate::tests::Dialog;
    use slint::{ComponentHandle, PhysicalPosition};
    #[test]
    fn show_dialog() -> anyhow::Result<()> {
        let (server, name): (
            ipc_channel::ipc::IpcOneShotServer<super::IpcMessage>,
            String,
        ) = ipc_channel::ipc::IpcOneShotServer::new()?;

        let handle = std::thread::spawn(move || {
            let (_rx, data) = server.accept().unwrap();

            loop {
                std::thread::sleep(std::time::Duration::from_millis(50));
                match &data {
                    super::IpcMessage::LabelMessage(label_text) => {
                        let label_text = label_text.to_string();
                        println!("[rust] : {:?}", label_text);
                        break;
                    }
                }
            }
        });

        super::show_dialog_x(name)?;

        match handle.join() {
            Ok(_) => println!("New thread finished."),
            Err(_) => println!("New thread panicked."),
        }

        anyhow::Ok(())
    }

    #[test]
    fn test2() -> anyhow::Result<()> {
        slint::slint! {
            export component Example inherits Window {
                preferred-width: 100px;
                preferred-height: 100px;
                Rectangle {
                    background: @linear-gradient (90deg, #3f87a6 0%, #ebf8e1 50%, #f69d3c 100%);
                }
            }
        }

        let window = Example::new()?;
        window.show()?;
        std::thread::sleep(std::time::Duration::from_secs(2));
        // Do some work...
        window.hide()?; // The window will be auto disposed if no other references.
        anyhow::Ok(())
    }

    #[test]
    fn auto_hide_window() -> anyhow::Result<()> {
        let dialog = Dialog::new()?;
        dialog
            .window()
            .set_position(slint::PhysicalPosition::new(0, 0));
        let _dialog_handle = dialog.as_weak();
        dialog.on_close_dialog(move || {
            println!("close");
        });

        dialog.show()?;
        std::thread::spawn(move || {
            std::thread::sleep(std::time::Duration::from_secs(2));
            slint::invoke_from_event_loop(move || {
                let _ = _dialog_handle.unwrap().hide();
            })
            .unwrap();
        });

        slint::run_event_loop()?;

        anyhow::Ok(())
    }
}
