import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isForRent = true;
  RangeValues priceRange = const RangeValues(400, 1200);
  String selectedHouseType = 'Real Estate';
  int selectedRooms = 0;
  int selectedBathrooms = 0;
  List<String> amenities = ['Garage', 'WiFi', 'Pool', 'Gym'];
  Set<String> selectedAmenities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Filter Property",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              // Reset filter settings
              setState(() {
                isForRent = true;
                priceRange = const RangeValues(400, 1200);
                selectedHouseType = 'Real Estate';
                selectedRooms = 0;
                selectedBathrooms = 0;
                selectedAmenities.clear();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // For Rent / For Sale Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleOption('For Rent', isForRent),
                  _buildToggleOption('For Sale', !isForRent),
                ],
              ),
              const SizedBox(height: 15),
              // Price Range Slider
              const Text("Price range", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              RangeSlider(
                values: priceRange,
                min: 0,
                max: 2000,
                divisions: 40,
                labels: RangeLabels("\$${priceRange.start.toInt()}K", "\$${priceRange.end.toInt()}K"),
                onChanged: (RangeValues values) {
                  setState(() {
                    priceRange = values;
                  });
                },
                activeColor: Colors.orange,
                inactiveColor: Colors.grey[300],
              ),
              const SizedBox(height: 10),
              // House Type Chips
              const Text("House Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: ['Real Estate', 'Apartment', 'House', 'Motels']
                    .map((type) => ChoiceChip(
                          label: Text(type),
                          selected: selectedHouseType == type,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedHouseType = selected ? type : selectedHouseType;
                            });
                          },
                          selectedColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                          labelStyle: TextStyle(
                            color: selectedHouseType == type ? Colors.white : Colors.black,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 15),
              // Rooms and Bathrooms Selection
              const Text("Rooms", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildNumberSelector((int selected) {
                setState(() {
                  selectedRooms = selected;
                });
              }, selectedRooms),
              const SizedBox(height: 10),
              const Text("Bathrooms", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildNumberSelector((int selected) {
                setState(() {
                  selectedBathrooms = selected;
                });
              }, selectedBathrooms),
              const SizedBox(height: 15),
              // Amenities
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Amenities", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text("Show All")),
                ],
              ),
              Wrap(
                spacing: 8,
                children: amenities
                    .map((amenity) => FilterChip(
                          label: Text(amenity),
                          selected: selectedAmenities.contains(amenity),
                          onSelected: (isSelected) {
                            setState(() {
                              isSelected ? selectedAmenities.add(amenity) : selectedAmenities.remove(amenity);
                            });
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedAmenities.contains(amenity) ? Colors.white : Colors.black,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 15),
              // Save Filter Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filter action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Save Filter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isForRent = label == 'For Rent';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildNumberSelector(ValueChanged<int> onSelected, int selectedNumber) {
    return Wrap(
      spacing: 8,
      children: List<Widget>.generate(5, (int index) {
        int number = index + 1;
        return ChoiceChip(
          label: Text(number == 5 ? '4+' : '$number'),
          selected: selectedNumber == number,
          onSelected: (bool selected) {
            onSelected(selected ? number : 0);
          },
          selectedColor: Colors.black,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: selectedNumber == number ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
