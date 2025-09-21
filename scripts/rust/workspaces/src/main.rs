use std::{ops::Range, process::Command};

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

    let active: Vec<i32> = parsed.iter().map(|w| w.id).collect();
    let workspaces = 1..active.last().unwrap() + 2;

    let buttons: Vec<String> = workspaces
        .map(|n| {
            let class = if active.contains(&n) {
                "active"
            } else {
                "inactive"
            };

            format!(
                "(button :onclick \"hyprctl dispatch workspace\" :class \"{}\" {})",
                class, n
            )
        })
        .collect();

    println!(
        "(box :class \"workspaces\" :orientation \"h\" :halign \"start\" :valign \"center\" :spacing 10 {})",
        buttons.join(" ")
    )
}
