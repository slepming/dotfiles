use std::process::Command;

use serde::{Deserialize, Serialize};

pub type Workspaces = Vec<WorkspaceElement>;

#[derive(Serialize, Deserialize, PartialEq, PartialOrd, Eq, Ord)]
#[serde(rename_all = "camelCase")]
pub struct WorkspaceElement {
    id: i32,
    name: String,
    monitor: String,
    #[serde(rename = "monitorID")]
    monitor_id: i32,
    windows: i32,
    hasfullscreen: bool,
    lastwindow: String,
    lastwindowtitle: String,
    ispersistent: bool,
}

fn main() {
    let result = Command::new("hyprctl")
        .arg("workspaces")
        .arg("-j")
        .output()
        .unwrap();
    let output = result.stdout;
    let mut parsed: Workspaces =
        serde_json::from_str(String::from_utf8(output).unwrap().as_ref()).unwrap();

    parsed.sort();

    let mut buttons: String = "".to_string();

    for i in parsed {
        buttons += format!(
            "(button :onclick \"hyprctl dispatch workspace {}\" \"{}\") ",
            i.id, i.id
        )
        .as_ref();
    }

    println!(
        "(box :class \"workspaces\" :orientation \"h\" :halign \"start\" :valign \"center\" :spacing 10 {})",
        buttons
    )
}
