import 'package:flutter/material.dart';

Widget customCard({required IconData icon , required String title, required String subtitle,required Widget page,required BuildContext context,}){
  return Expanded(
    child: TextButton(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: Colors.cyan,),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(right: 5),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left:20,),
              child: Align(
                alignment: Alignment.center,
                child: Text(

                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      } ,
    ),
  );
}
Widget alignCard({
  required IconData icon,
  required String title,
  required Widget page,
  required BuildContext context,
}) {
  return Expanded(
    child: TextButton(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Icon(icon, color: Colors.cyan, size: 70),
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *0.75,
                  padding: EdgeInsets.only(right: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    ),
  );
}
Widget statCard({required IconData icon , required String title, required String subtitle,required int nombrereclam , required Color color}){
  return Expanded(
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: color,),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize:20,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left:20,),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:20,),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                nombrereclam.toString(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
