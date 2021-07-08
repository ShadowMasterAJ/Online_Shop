import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EdiUserProductsStateScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  @override
  _EdiUserProductsStateScreenState createState() =>
      _EdiUserProductsStateScreenState();
}

class _EdiUserProductsStateScreenState
    extends State<EdiUserProductsStateScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  Map<String, String> _initValues = {
    'title': '',
    'description': '',
    'imageURL': '',
    'price': '',
  };
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    imageURL: '',
    price: 0,
  );

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImageURL);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageURLFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(productID);

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'imageURL': '',
          'price': _editedProduct.price.toString()
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    }
    print(_editedProduct.title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange,
          Colors.deepOrange,
          Colors.deepOrange,
          Colors.orange,
        ],
      )),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Product',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.check))],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          initialValue: _initValues['title'],
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                    ),
                            errorStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 16,
                                      color: Colors.red[900],
                                    ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a title!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          onSaved: (value) => {
                            _editedProduct = Product(
                              title: value,
                              description: _editedProduct.description,
                              imageURL: _editedProduct.imageURL,
                              price: _editedProduct.price,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                            )
                          },
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          initialValue: _initValues['price'],
                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                    ),
                            errorStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 16,
                                      color: Colors.red[900],
                                    ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a price!';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number!';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Please enter a number greater than zero!';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          onSaved: (value) => {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              imageURL: _editedProduct.imageURL,
                              price: double.parse(value),
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                            )
                          },
                        ),
                        TextFormField(
                          maxLines: null,
                          style: Theme.of(context).textTheme.headline5,
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                    ),
                            errorStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 16,
                                      color: Colors.red[900],
                                    ),
                          ),
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a description!';
                            }
                            if (value.length < 10) {
                              return 'Must be atleast 10 characters!';
                            }
                            return null;
                          },
                          onSaved: (value) => {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              description: value,
                              imageURL: _editedProduct.imageURL,
                              price: _editedProduct.price,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                            )
                          },
                        ),
                        TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Image URL',
                            labelStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                    ),
                            errorStyle:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 16,
                                      color: Colors.red[900],
                                    ),
                          ),
                          maxLines: null,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) => _saveForm(),
                          focusNode: _imageURLFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an image URL!';
                            }
                            if (!value.startsWith('http://') &&
                                !value.startsWith('https://')) {
                              return 'Please enter a valid URL!';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg')) {
                              return 'Please enter a valid image URL!';
                            }
                            return null;
                          },
                          onSaved: (value) => {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              imageURL: value,
                              price: _editedProduct.price,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                            )
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: 350,
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(30)),
                          child: _imageUrlController.text.isEmpty
                              ? Center(
                                  child: Text(
                                    'Image Preview',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.grey[800],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
