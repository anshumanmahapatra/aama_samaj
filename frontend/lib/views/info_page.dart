import 'package:aama_samaj_temp_frontend/widgets/blog_tile.dart';
import 'package:aama_samaj_temp_frontend/widgets/youtube_video_tile.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
              text: "Information",
              style: TextStyle(
                  color: Color(0xFF071E22),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Color(0xFF071E22)),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BlogTab(
                img:
                    "https://cms.bhubaneswarone.in/uploadDocuments/content/Rajiv-Awas-Yojana.jpg",
                title: "Rajiv Awas Yojana-BMC",
                desc:
                    "Rajiv Awas Yojana (RAY) for the slum dwellers and the urban poor envisages a ‘Slum-free India’ through encouraging States/Union Territories to tackle the problem of slums in a definitive manner. ",
                postUrl: "https://www.bmc.gov.in/programs/rajiv-awas-yojana"),
            const SizedBox(
              height: 15,
            ),
            BlogTab(
                img:
                    "https://cms.bhubaneswarone.in/uploadDocuments/content/Go-Green-Drive.jpg",
                title: "Go Green Drive",
                desc:
                    "The environmental problems in Bhubaneswar are growing rapidly with the increasing economic development and a rapidly growing population. Industrial pollution, soil erosion, deforestation, rapid industrialization, urbanization, and land degradation are all worsening problems.",
                postUrl: "https://www.bmc.gov.in/programs/go-green-drive"),
            const SizedBox(
              height: 15,
            ),
            YoutubeVideoTile(
              img: "https://img.youtube.com/vi/R5N3eVQXpAA/sddefault.jpg",
              title: "Pest Control (Module 11) | FSSAI",
              postUrl: "https://www.youtube.com/watch?v=R5N3eVQXpAA",
              channelName: 'Food Safety and Standards Authority of India',
              logo:
                  "https://yt3.ggpht.com/ytc/AKedOLRq922DvXpAYEAUeEhPG3fNI66G-aA79D3OSYEy=s48-c-k-c0x00ffffff-no-rj",
            ),
            SizedBox(
              height: 15,
            ),
            YoutubeVideoTile(
              img: "https://img.youtube.com/vi/q5egJZ0Jvfg/sddefault.jpg",
              title: "A short video on prevention and control of dengue",
              postUrl: "https://www.youtube.com/watch?v=q5egJZ0Jvfg",
              channelName: 'PIB India',
              logo:
                  "https://yt3.ggpht.com/ytc/AKedOLTGDKOUqYd_L-ilKzvtosQsHEQcOj6cAbKPa_z_pw=s48-c-k-c0x00ffffff-no-rj",
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
