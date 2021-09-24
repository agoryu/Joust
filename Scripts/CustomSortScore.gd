extends Node

class_name CustomSortScore
	
static func sort_ascending(a, b):
	return a[0] < b[0]
	
static func sort_descending(a, b):
	return a[0] > b[0]
