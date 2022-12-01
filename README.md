# little_miracles_orphange

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


 ListView(children: [

    //     TabBarView(
    //   children: [
    //     Icon(Icons.flight, size: 350),
    //     Icon(Icons.directions_transit, size: 350),
    //     Icon(Icons.directions_car, size: 350),
    //   ],
    // ),

        Image.asset("assets/images/logo.png"),
        for (int i = 0; i < placeHolderList.length; i++) ...[
          Text(placeHolderList[i]),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(hintText: placeHolderList[i]),
              onChanged: functions[i],
            ),
          )
        ],
        ElevatedButton(
            onPressed: () {
              setState(() {
                print("set state is called");
              });
            },
            child: Text("Pressed me!"))
      ])