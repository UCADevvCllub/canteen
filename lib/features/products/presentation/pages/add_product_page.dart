import 'package:auto_route/auto_route.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FilteringTextInputFormatter
import 'package:provider/provider.dart';
import 'package:canteen/features/products/domain/models/product.dart';
import 'package:canteen/core/widgets/fields/app_text_form_field.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker

@RoutePage()
class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController(); // Add controller for image URL
  String? _selectedCategoryId;
  int _quantity = 1;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose(); // Dispose the new controller
    super.dispose();
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageController.text = image.path; // Store the image path
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  // Function to take a photo with the camera
  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _imageController.text = photo.path; // Store the photo path
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take photo: $e')),
      );
    }
  }

  // Function to show the image source selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addProduct(BuildContext context) async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    if (_nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _selectedCategoryId != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final newProduct = Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: _nameController.text,
          description: _descriptionController.text.isNotEmpty
              ? _descriptionController.text
              : null,
          price: double.parse(_priceController.text),
          categoryId: _selectedCategoryId!,
          quantity: _quantity,
          imageUrl: _imageController.text.isNotEmpty ? _imageController.text : null, // Include image URL
        );
        await provider.addProduct(newProduct);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add product: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Expanded(
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 16),

                // Product Photo Placeholder
                GestureDetector(
                  onTap: _showImageSourceDialog, // Trigger dialog on tap
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _imageController.text.isNotEmpty
                        ? Image.network(
                      _imageController.text,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 50, color: Colors.red),
                          Text(
                            'Failed to load image',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.grey),
                        Text(
                          'Add Product Photo',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Product Name
                AppTextFormField(
                  hintText: 'Product name',
                  controller: _nameController,
                  maxLines: 1,
                ),
                const SizedBox(height: 16),

                // Price and Category Row
                Row(
                  children: [
                    // Price
                    Expanded(
                      child: AppTextFormField(
                        hintText: 'Price',
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        suffixText: 'som',
                        maxLines: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allow only numbers
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Category Dropdown
                    Expanded(
                      child: Consumer<ProductProvider>(
                        builder: (context, provider, _) {
                          if (provider.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (provider.categories.isEmpty) {
                            return const Text('No categories available');
                          }
                          return DropdownButtonFormField<String>(
                            value: _selectedCategoryId,
                            hint: const Text('Category'),
                            isExpanded: true, // Ensure the dropdown takes full width
                            items: provider.categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(
                                  category.name,
                                  overflow: TextOverflow.ellipsis, // Handle long text
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategoryId = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            isDense: true, // Make the dropdown more compact
                            menuMaxHeight: 200, // Limit the dropdown menu height
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quantity Row
                Row(
                  children: [
                    // Quantity
                    Expanded(
                      child: Row(
                        children: [
                          const Text('Quantity', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (_quantity > 1) {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            },
                          ),
                          Text('$_quantity', style: const TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                AppTextFormField(
                  hintText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _addProduct(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Add Product',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}