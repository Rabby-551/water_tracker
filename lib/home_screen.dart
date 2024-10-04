
import 'package:flutter/material.dart';
import 'package:water_tracker/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoController = TextEditingController(
    text: '1',
  );

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterTrackCounter(),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: _buildWaterTrackListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final WaterTrack waterTrack = waterTrackList[index];
        return _buildWaterTrackListTile(waterTrack,index);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
Widget _buildWaterTrackListTile( WaterTrack waterTrack, int index){
    return ListTile(
      title:
      Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
      subtitle: Text(
          '${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
      leading: CircleAvatar(child: Text('${waterTrack.noOfGlasses}')),
      trailing: IconButton(
        onPressed:() => _onTaoDeleteButton(index),
        icon: Icon(Icons.delete),
      ),
    );
}
  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                controller: _glassNoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: _onTapAddWaterTrack,
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void _onTapAddWaterTrack() {
    if (_glassNoController.text.isEmpty) {
      _glassNoController.text = '1';
    }

    final int noOfglasses = int.tryParse(_glassNoController.text) ?? 1;
    WaterTrack waterTrack = WaterTrack(
      noOfGlasses: noOfglasses,
      dateTime: DateTime.now(),
    );
    waterTrackList.add(waterTrack);
    setState(() {});
  }

  void _onTaoDeleteButton(int index){
    waterTrackList.removeAt(index);
    setState(() {

    });
  }
}


