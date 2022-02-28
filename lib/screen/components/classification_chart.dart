import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassificationDialog extends StatelessWidget {
  ClassificationDialog({
    Key? key,
    this.radius = 8,
    required this.mdFileName,
  })  : assert(mdFileName.contains('.jpeg'), 'The file must contain the .jpeg extension'),
        super(key: key);

  final double radius;
  final String mdFileName;
  bool loadedData = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 500)).then((value) {
                loadedData = false;
              }),
              builder: (context, shot) {
                if (loadedData == false) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 0.5,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Image.asset(
                      'assets/$mdFileName',
                      fit: BoxFit.fill,
                      
                    )
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            color: Theme.of(context).buttonColor,
            onPressed: () => Navigator.of(context).pop(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              alignment: Alignment.center,
              height:50,
              width: double.infinity,
              child: Text(
                "CLOSE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF363f93),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}