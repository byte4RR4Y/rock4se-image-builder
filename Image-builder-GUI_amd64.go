package main

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/therecipe/qt/widgets"
)

func main() {
	app := widgets.NewQApplication(len(os.Args), os.Args)

	// Hauptfenster erstellen
	window := widgets.NewQMainWindow(nil, 0)
	window.SetWindowTitle("ROCK 4 SE BUILDER")

	// Zentralen Widget-Erstellen
	centralWidget := widgets.NewQWidget(nil, 0)
	window.SetCentralWidget(centralWidget)

	// Layout für zentrales Widget erstellen
	layout := widgets.NewQVBoxLayout()
	centralWidget.SetLayout(layout)

	// Dropdown-Menü mit sechs Auswahlmöglichkeiten erstellen
	label1 := widgets.NewQLabel2("SUITE:", nil, 0)
	layout.AddWidget(label1, 0, 0)
	comboBox1 := widgets.NewQComboBox(nil)
	comboBox1.AddItems([]string{"testing", "experimental", "trixie", "sid", "bookworm", "bullseye"})
	layout.AddWidget(comboBox1, 0, 0)

	// Dropdown-Menü mit zehn Auswahlmöglichkeiten erstellen
	label2 := widgets.NewQLabel2("DESKTOP:", nil, 0)
	layout.AddWidget(label2, 0, 0)
	comboBox2 := widgets.NewQComboBox(nil)
	comboBox2.AddItems([]string{"none", "xfce4", "gnome", "mate", "cinnamon", "lxqt", "lxde", "unity", "budgie", "kde"})
	layout.AddWidget(comboBox2, 0, 0)

	// Checkbox für zusätzliche Software erstellen
	interactiveShellCheckBox := widgets.NewQCheckBox2("Interactive Shell", nil)
	layout.AddWidget(interactiveShellCheckBox, 0, 0)

	// Texteingabefeld für Benutzernamen erstellen
	usernameLabel := widgets.NewQLabel2("USERNAME:", nil, 0)
	layout.AddWidget(usernameLabel, 0, 0)
	usernameLineEdit := widgets.NewQLineEdit(nil)
	layout.AddWidget(usernameLineEdit, 0, 0)

	// Texteingabefeld für Passwort erstellen
	passwordLabel := widgets.NewQLabel2("PASSWORD:", nil, 0)
	layout.AddWidget(passwordLabel, 0, 0)
	passwordLineEdit := widgets.NewQLineEdit(nil)
	passwordLineEdit.SetEchoMode(2) // EchoModePassword
	layout.AddWidget(passwordLineEdit, 0, 0)

	// Button erstellen
	buildButton := widgets.NewQPushButton2("Build", nil)
	layout.AddWidget(buildButton, 0, 0)

	// Verbindung von Button mit Funktion
	buildButton.ConnectClicked(func(bool) {
		// Ausgewählte Werte abrufen
		suite := comboBox1.CurrentText()
		desktop := comboBox2.CurrentText()
		interactiveShell := "no"
		if interactiveShellCheckBox.IsChecked() {
			interactiveShell = "yes"
		}
		username := usernameLineEdit.Text()
		password := passwordLineEdit.Text()

		// build.sh-Skript ausführen
		cmd := exec.Command("xfce4-terminal", "--title=Image-Builder", "-e", fmt.Sprintf("sudo ./build.sh -s %s -d %s -i %s -u %s -p %s -b", suite, desktop, interactiveShell, username, password))
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		err := cmd.Run()
		if err != nil {
			fmt.Println("Error running build script:", err)
			return
		}
	})

	// Fenster anzeigen
	window.Show()

	// Anwendung ausführen
	app.Exec()
}
