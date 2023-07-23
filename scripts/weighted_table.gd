class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item, weight: int) -> void:
	weight_sum += weight
	items.append({"item": item, "weight": weight})


func pick_item():
	var chosen_weight = randi_range(1, weight_sum)
	var iteration_sum = 0
	for item in items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
