import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';




import 'package:intl/intl.dart';


  class FormTest extends StatefulWidget {

    @override
  _FormTestState createState() => _FormTestState();
  }

  class _FormTestState extends State<FormTest> {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List<String> organizations = ['Select The Organisation', 'Wildlife Conservation', 'Forest Conservation',];
    String? selectedOrganization = 'Select The Organisation';
    DateTime selectedDate = DateTime.now();
    File? _selectedImage;



    Widget _buildNameField(){
      return TextFormField(
          maxLength: 30,
          decoration: InputDecoration(
              hintText: 'Name',border: OutlineInputBorder()),
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name cannot be empty';
            }
            return null;
          },
          onSaved: (value){

          }
    );
    }
    Widget _buildAddressField(){
      return TextFormField(
          maxLength: 30,
          decoration: InputDecoration(hintText: 'Address',border: OutlineInputBorder()),
          maxLines: 2,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Address cannot be empty';
            }
            return null;
          },
          onSaved: (value){

          }
      );
    }
    Widget _buildLocationField(){
      return TextFormField(
          maxLength: 30,
          decoration: InputDecoration(hintText: 'Location',border: OutlineInputBorder()),
          maxLines: 2,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Location cannot be empty';
            }
            return null;
          },
          onSaved: (value){

          }
      );
    }
    Widget _buildIdField(){
      return TextFormField(
          maxLength: 12,
          decoration: InputDecoration(hintText: 'National Id',border: OutlineInputBorder()),
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Address cannot be empty';
            }
            return null;
          },
          onSaved: (value){

          }
      );
    }
    Widget _buildEmailField(){
      return TextFormField(
          maxLength: 30,
          decoration: InputDecoration(hintText: 'Email',border: OutlineInputBorder()),
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email cannot be empty';
            }
            return null;
          },
          onSaved: (value){

          }
      );
    }
    Widget _buildDescriptionField(){
      return TextFormField(
          maxLength: 300,
          decoration: InputDecoration(hintText: 'Description',border: OutlineInputBorder()),
          maxLines: 6,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email cannot be empty';
            }
            return null;
          },
          onSaved: (value){

          }
      );
    }
    Widget _buildDatePicker() {
      return Row(
        children: [
          Text('Enter a date and time of incident: ${selectedDate.toLocal()}'.split(' ')[0]),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      );
    }
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (pickedDate != null && pickedDate != selectedDate) {
        // Show Time Picker
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
        );
        if (pickedTime != null) {
          // Combine Date and Time
          DateTime pickedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          String formattedDateTime = DateFormat.yMd().add_jm().format(pickedDateTime);

          setState(() {
            selectedDate = pickedDateTime;
            print('Selected Date and Time: $formattedDateTime');
          });
        }
      }
    }


    Future<void> _pickImageFromGallery() async {
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        setState(() {
          _selectedImage = File(returnedImage.path);
        });
      }
    }



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Complain', style: TextStyle(
            fontWeight: FontWeight.bold, // Set the text to bold
          ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              margin: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  _buildNameField(),
                  _buildIdField(),
                  _buildEmailField(),
                  _buildAddressField(),
                  _buildLocationField(),
                  _buildDescriptionField(),
                  DropdownButtonFormField<String>(
                    value: selectedOrganization,
                    decoration: InputDecoration
                      (border: OutlineInputBorder()),
                    hint: Text('Select Organization'),
                    onChanged: (String? value) {
                      setState(() {
                        selectedOrganization = value;
                      });
                    },
                    items: organizations.map((String organization) {
                      return DropdownMenuItem<String>(
                        value: organization,
                        child: Text(organization),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an organization';
                      }
                      return null;
                    },
                  ),

                  _buildDatePicker(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: _pickImageFromGallery,
                      child: const Text(
                        'Pick Image from Gallery',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _selectedImage != null
                      ? Image.file(_selectedImage!)
                      : const Text('Please Select an Image'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {

                    if (formKey.currentState!.validate()) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Set the background color here
                        onPrimary: Colors.white, // Set the text color here
                          elevation: 5, // Elevation (shadow) of the button
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    ),// Rounded corners
                  child:  Text('Save'),
                ),
              ),

                ],
              ),
            ),
          ),
        ),
      );
    }
  }



