# Simple File Handle Inspector

A utility for checking which processes are using a specific file or folder, directly from the Windows context menu.

---

## ⚙️ Features

- Adds context menu entries for files and folders:
  - 🧩 `Find which process is using this file`
  - 📂 `Find which process is using this folder`
- Uses Sysinternals' `handle.exe` to detect file locks
- Displays the process name, PID, and full executable path
- Includes a cleanup shortcut to remove the context menu entries

---

## 🪛 Installation and usage

1. **Run the `configure.bat`**  
   This sets up the context menu entries.

2. **Right-click a file or folder → choose the new context menu item**  
   The utility will open and show the processes that are locking the file or folder.

---

## 🧹 Cleanup

**To uninstall/remove the context menu entries, run the `cleanup (run before deleting the utility).bat`**

This will safely remove all registry entries.

After that, it's safe to delete the utility folder.

---

## 🪟 Windows 11 Notes

Due to UI changes in Windows 11, context menu entries may appear under **"Show more options"** (Shift + Right Click).  
This is a Windows limitation and cannot be bypassed via registry keys alone.

---

## 📄 License & Acknowledgements

- This utility uses [`handle.exe`](https://learn.microsoft.com/en-us/sysinternals/downloads/handle) from [Microsoft Sysinternals](https://learn.microsoft.com/en-us/sysinternals/)
- `handle.exe` and its EULA are included unmodified
- This utility does **not modify** or redistribute the Sysinternals binary in any altered form

---

## 🔐 Privacy

No data is sent or collected. All operations happen locally on your machine.

---

## 🧠 Notes

You can safely move the utility's folder. Just re-run the **`configure.bat`** after moving it.

---

## ⚠️ Download Warning
Some browsers (like Microsoft Edge or Google Chrome) may block the download of this utility's archive.
This is a **false positive** — a precaution triggered by the presence of batch files.

The utility is fully open-source, contains no networking code, and does not collect any data.

How to proceed:
- Download the files manually from this repository
- Or clone the repository using `git clone`

---

## 🙋 Contact

Feel free to reach out with suggestions, questions, or improvements:

- 🔗 [GitHub](https://github.com/stack-rift)
- ✉️ stackrift35@gmail.com

---

Enjoy!
