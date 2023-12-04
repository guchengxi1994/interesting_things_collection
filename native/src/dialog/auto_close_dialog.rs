slint::slint! {
    import { Button , HorizontalBox, VerticalBox} from "std-widgets.slint";
    export component AutoCloseDialog inherits Window {
        // title: "对话框";
        width: 300px;
        height: 200px;
        no-frame: true;
        icon: @image-url("icon.png");

        Rectangle {
            background: @linear-gradient (90deg, #cde4ee 0%, #ebf8e1 100%);
        }

        callback close-dialog();

        // VerticalBox {
        //     Text {
        //         text: "对话框";
        //         color: green;
        //     }
        //     Button {
        //         text: "返回数据并关闭";
        //         width: 120px;
        //         height: 40px;
        //         clicked => {
        //             close-dialog()
        //         }
        //     }
        // }
    }
}

pub fn show_auto_close_dialog() -> anyhow::Result<()> {
    let dialog = AutoCloseDialog::new()?;
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
