extends Container

signal Cassette_Sent
onready var Main_Monitor = get_node("/root/MiMo/Editor/Main_Monitor")

var all_cartridges_returned = true
var subject = ""

func _ready():
	$Cassette_Slot.insert_object({"n": 1, "bars": 0})
	$Eject_Button.connect("button_up", $Cassette_Slot, "eject_cassette")
	$Send_Button.connect("button_up", self, "on_send")

func on_send():
	if $Cassette_Slot.is_empty():
		if Main_Monitor:
			Main_Monitor.display("please insert a video cassette", 3)
		return
	
	if $Cassette_Slot.inserted.active_bars == 0:
		if Main_Monitor:
			Main_Monitor.display("the cassette is empty", 3)
		return

	if !all_cartridges_returned:
		if Main_Monitor:
			Main_Monitor.display("return all cartridges into the rack", 3)
		return
	
	# should verify the cassette and emmit a signal
	var data = $Cassette_Slot.get_data()
	data["subject"] = self.subject
	emit_signal("Cassette_Sent", data)