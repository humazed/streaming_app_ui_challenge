import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app_ui_challange/pages/points_provider.dart';
import 'package:streaming_app_ui_challange/widgets/star_button.dart';

import '../generated/r.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          buildStories(),
          buildPost(),
        ],
      ),
    );
  }

  Widget buildStories() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 132,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            buildStory('Feed', R.feed),
            buildStory('\$ 1k Contest', R.contest, contest: true),
            buildStory('Ninja', R.ninja, notificationCount: 3),
            buildStory('pokimane', R.pokimane, notificationCount: 7),
            buildStory('DrLupo', R.drlupo, watched: true),
            buildStory('King Richard', R.kingRichard, watched: true),
          ],
        ),
      ),
    );
  }

  Widget buildStory(
    String title,
    String image, {
    int notificationCount = 0,
    bool watched = false,
    bool contest = false,
  }) {
    var textColor = Color(0xFFB6BCBE);
    if (contest) textColor = Colors.white;
    if (watched) textColor = Color(0xFF4B5A61);

    var borderGradient = [Color(0xffffb054), Color(0xFF8F6BEF)];
    if (contest) borderGradient = [Colors.white, Colors.white];
    if (watched) borderGradient = [Color(0xFF2B383F), Color(0xFF2B383F)];

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 88),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: borderGradient,
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 56,
                  height: 56,
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (notificationCount > 0 || contest)
                PositionedDirectional(
                  end: 0,
                  top: contest ? 0 : -5,
                  child: Container(
                    padding: EdgeInsets.all(contest ? 2 : 6),
                    decoration: BoxDecoration(
                      color: contest ? Colors.white : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: contest
                        ? Icon(Icons.star, color: Colors.black, size: 18)
                        : Text(
                            notificationCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget buildPost() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildPostTitle(),
        SizedBox(height: 16),
        buildPostImage(),
        SizedBox(height: 16),
        buildComments(),
        buildPostInfo(),
      ],
    );
  }

  Row buildPostTitle() {
    return Row(
      children: <Widget>[
        SizedBox(width: 16),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NYC was fun but I'm back!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Flexible(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      "32.1k views ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
                    Text(
                      "JinJuh ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
                    Text(
                      "clipped 5g ago",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
//            Spacer(),
        IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0xFF333532), borderRadius: BorderRadius.circular(4)),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Icon(Icons.stars, color: Color(0xffffb054)),
                SizedBox(width: 8),
                Consumer<PointsProvider>(
                  builder: (context, pointsProvider, _) {
                    return Text(
                      pointsProvider.myPoints.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffffb054),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  SizedBox buildPostImage() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: Image.asset(
              R.postPlaceholder,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF313B40).withOpacity(.9),
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "#12 in Today's Top Clip Contest",
                          style: TextStyle(),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Text(
                              '\$1k Prize Pool  ',
                              style: TextStyle(
                                color: Color(0xffffb054),
                              ),
                            ),
                            Text(
                              '3h 45m 32s  1,029 Entries',
                              style: TextStyle(
                                color: Color(0xFFB6BCBE),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF7F8689),
                      size: 36,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComments() {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: 100,
          child: Column(
            children: [
              buildComment(
                'drg5',
                commentSpans: [
                  TextSpan(text: 'just liked this'),
                  TextSpan(
                    text: ' 100 ',
                    style: TextStyle(
                      color: Color(0xffffb054),
                    ),
                  ),
                  TextSpan(text: 'times!'),
                ],
              ),
              buildComment('ninja', comment: '💥💥💥💥💥💥💥'),
              buildComment('yuierooo',
                  comment: 'how do you even do that 🎉🎉🎉🎉🎉🎉🎉'),
              buildComment('yuierooo', comment: 'im gon try that! ❤❤❤❤'),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2E2E2E),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildComment(String author,
      {String comment, List<InlineSpan> commentSpans}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            SizedBox(width: 16),
            Text(
              author,
              style: TextStyle(),
            ),
            SizedBox(width: 16),
            Flexible(
              child: comment == null
                  ? RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Color(0xFFB6BCBE),
                        ),
                        children: commentSpans,
                      ),
                    )
                  : Text(
                      comment,
                      style: TextStyle(
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildPostInfo() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                SizedBox(width: 16),
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        R.ninja,
                        width: 56,
                        height: 56,
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 0,
                      end: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xFF6F4BFF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          'Ninja',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.check_circle,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '8.9k Followers',
                      style: TextStyle(
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Icon(Icons.share),
                    SizedBox(height: 8),
                    Text(
                      'Share',
                      style: TextStyle(
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Icon(Icons.message),
                    SizedBox(height: 8),
                    Text(
                      '102',
                      style: TextStyle(
                        color: Color(0xFFB6BCBE),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    StarButton(
                      onPressed: () {
                        PointsProvider.of(context).givePoints(10);
                      },
                    ),
                    SizedBox(height: 8),
                    Consumer<PointsProvider>(
                      builder: (context, pointsProvider, _) {
                        return Text(
                          pointsProvider.postPoints.toString(),
                          style: TextStyle(
                            color: Color(0xffffb054),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
