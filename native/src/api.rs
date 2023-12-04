pub fn say_hello() {
    println!("[rust] Hello, world!");
}

pub fn show_auto_close_dialog() {
    println!("[rust] open dialog");
    let r = crate::dialog::auto_close_dialog::show_auto_close_dialog();
    match r {
        Ok(_) => {
            println!("[rust] close dialog");
        }
        Err(e) => {
            println!("[rust] error {:?}", e);
        }
    }
}
