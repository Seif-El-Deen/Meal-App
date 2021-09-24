import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool?> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _glutenFree;
  bool? _lactoseFree;
  bool? _vegan;
  bool? _vegetarian;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];

    super.initState();
  }

  Widget buildSwitchListTile({
    required String title,
    required String subTitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  title: 'Gluten Free',
                  subTitle: 'Only include gluten-free meals',
                  value: _glutenFree ?? false,
                  onChanged: (bool value) {
                    setState(() {
                      _glutenFree = value;
                    });
                    print(value);
                  },
                ),
                buildSwitchListTile(
                  title: 'Lactose Free',
                  subTitle: 'Only include lactose-free meals',
                  value: _lactoseFree ?? false,
                  onChanged: (bool value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                    print(value);
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegan ',
                  subTitle: 'Only include vegan meals',
                  value: _vegan ?? false,
                  onChanged: (bool value) {
                    setState(() {
                      _vegan = value;
                    });
                    print(value);
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegetarian',
                  subTitle: 'Only include vegetarian meals',
                  value: _vegetarian ?? false,
                  onChanged: (bool value) {
                    setState(() {
                      _vegetarian = value;
                    });
                    print(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
