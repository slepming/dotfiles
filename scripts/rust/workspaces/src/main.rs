use std::{process::Command, str::FromStr};

use serde::{Deserialize, Serialize};

pub type Workspaces = Vec<WorkspaceElement>;

#[derive(Serialize, Deserialize, PartialEq, PartialOrd, Eq, Ord, Clone)]
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
    let current = Command::new("hyprctl")
        .arg("activeworkspace")
        .arg("-j")
        .output()
        .unwrap();
    let output = result.stdout;
    let mut parsed: Workspaces =
        serde_json::from_str(String::from_utf8(output).unwrap().as_ref()).unwrap();
    let cur_worksp = current.stdout;
    let current_workspace: WorkspaceElement =
        serde_json::from_str(String::from_utf8(cur_worksp).unwrap().as_ref()).unwrap();

    parsed.sort();

    let active: Vec<i32> = parsed.iter().map(|w| w.id).collect();
    let workspaces = 1..active.last().unwrap() + 1;

    let buttons: Vec<String> = workspaces
        .map(|n| {
            let class = if active.contains(&n) {
                if n == current_workspace.id {
                    "active current"
                } else {
                    "active"
                }
            } else {
                return "".to_string();
            }
            .to_string();

            format!(
                "(button :onclick \"hyprctl dispatch workspace\" :class \"{}\" {})",
                class, n
            )
        })
        .collect();

    println!(
        "(box :class \"workspaces\" :orientation \"h\" :halign \"start\" :valign \"center\" :space-evenly false :spacing 20 {})",
        buttons.join(" ")
    )
}
