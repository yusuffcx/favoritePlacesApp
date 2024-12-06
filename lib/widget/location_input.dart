import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
              border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
            width: 1,
          )),
          child: Text('No location selected',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
                icon: const Icon(Icons.location_on),
                onPressed: () {},
                label: const Text('Get Current Location')),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            )
          ],
        )
      ],
    );
  }
}
