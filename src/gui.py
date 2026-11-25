import tkinter as tk
from tkinter import ttk
from tkcalendar import DateEntry

root = tk.Tk()
root.title("Clinic Management System")
root.geometry("900x800")

mainFrame = tk.Frame(root, padx=20, pady=20)
mainFrame.pack(fill="both", expand=True)

titleLabel = tk.Label(
    mainFrame,
    text="Clinc Management System",
    font=("Arial", 20, "bold")
)
titleLabel.pack(pady=10)

# form elements #

formFrame = tk.LabelFrame(
    mainFrame,
    text="Appointment Details",
    padx=15,
    pady=15
)
formFrame.pack(fill="x", pady=10)

patientLabel = tk.Label(formFrame, text="Patient ID")
patientLabel.grid(row=0, column=0, padx=10, pady=5)

patientEntry = tk.Entry(formFrame)
patientEntry.grid(row=0, column=1, padx=10, pady=5)

doctorLabel = tk.Label(formFrame, text="Doctor ID:")
doctorLabel.grid(row=1, column=0, padx=10, pady=5)

doctorEntry = tk.Entry(formFrame)
doctorEntry.grid(row=1, column=1, padx=10, pady=5)

roomLabel = tk.Label(formFrame, text="Room ID:")
roomLabel.grid(row=2, column=0, padx=10, pady=5)

roomEntry = tk.Entry(formFrame)
roomEntry.grid(row=2, column=1, padx=10, pady=5)

staffLabel = tk.Label(formFrame, text="Staff ID:")
staffLabel.grid(row=3, column=0, padx=10, pady=5)

staffEntry = tk.Entry(formFrame)
staffEntry.grid(row=3, column=1, padx=10, pady=5)

dateLabel = tk.Label(formFrame, text="Appointment Date:")
dateLabel.grid(row=4, column=0, padx=10, pady=5)

dateEntry = DateEntry(formFrame, date_pattern="yyyy-mm-dd")
dateEntry.grid(row=4, column=1, padx=10, pady=5)

timeLabel = tk.Label(formFrame, text="Appointment Time:")
timeLabel.grid(row=5, column=0, padx=10, pady=5)

timeEntry = ttk.Combobox(
    formFrame,
    values=["09:00", "09:30", "10:00", "10:30", "11:00"],
    state="readonly"
)
timeEntry.grid(row=5, column=1, padx=10, pady=5)

# crud buttons #

buttonFrame = tk.Frame(mainFrame)
buttonFrame.pack(pady=10)

addButton = tk.Button(
    buttonFrame,
    text="Add",
    width=15
)
addButton.pack(side="left", padx=5)

updateButton = tk.Button(
    buttonFrame,
    text="Update",
    width=15
)
updateButton.pack(side="left", padx=5)

deleteButton = tk.Button(
    buttonFrame,
    text="Delete",
    width=15
)
deleteButton.pack(side="left", padx=5)

clearButton = tk.Button(
    buttonFrame,
    text="Clear",
    width=15
)
clearButton.pack(side="left", padx=5)

# table #

tableFrame = tk.LabelFrame(
    mainFrame,
    text="Appointments",
    padx=10,
    pady=10
)
tableFrame.pack(fill="both", expand=True, pady=10)

columns = (
    "AppointmentID",
    "PatientID",
    "DoctorID",
    "RoomID",
    "StaffID",
    "AppointmentDate",
    "AppointmentTime"
)

appointmentTable = ttk.Treeview(
    tableFrame,
    columns=columns,
    show="headings"
)

scrollbar = ttk.Scrollbar(
    tableFrame,
    orient="vertical",
    command=appointmentTable.yview
)
appointmentTable.configure(yscrollcommand=scrollbar.set)

appointmentTable.pack(side="left", fill="both", expand=True)
scrollbar.pack(side="right", fill="y")

for col in columns:
    appointmentTable.heading(col, text=col)
    appointmentTable.column(col, width=120, anchor="center")

root.mainloop()