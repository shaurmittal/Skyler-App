import 'package:findmyngo/constants/color_constants.dart';
import 'package:findmyngo/elements/home/controller/home_controller.dart';
import 'package:findmyngo/elements/home/widgets/custom_app_bar.dart';
import 'package:findmyngo/elements/home/widgets/drawer_widget.dart';
import 'package:findmyngo/utils/size/size_config.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final HomeController controller = HomeController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "FAQ",
        bottom: TabBar(
          indicatorColor: ColorConstants.darkGreen,
          labelColor: ColorConstants.darkGreen,
          controller: tabController,
          tabs: const [
            Tab(text: "NGO FAQ"),
            Tab(text: "USER FAQ"),
          ],
        ),
      ),
      drawer: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
          child: DrawerWidget(
            controller: controller,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          NGOFAQ(),
          USERFAQ(),
        ],
      ),
    );
  }
}

class FAQList extends StatelessWidget {
  final List<Map<String, String>> faqs;
  const FAQList({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          faqs.length,
          (index) => TextFAQ(
            index: index + 1, // Numbering starts from 1
            question: faqs[index]['question']!,
            answer: faqs[index]['answer']!,
          ),
        ),
      ),
    );
  }
}

class NGOFAQ extends StatelessWidget {
  const NGOFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return const FAQList(
      faqs: [
        {
          'question': "NGO FAQ ",
          'answer':
              "Lorem LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem"
        },
        {
          'question': "NGO FAQ ",
          'answer':
              "Lorem LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem"
        },
      ],
    );
  }
}

class USERFAQ extends StatelessWidget {
  const USERFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return const FAQList(
      faqs: [
        {
          'question': "USER FAQ QUESTION",
          'answer':
              "Lorem LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem"
        },
        {
          'question': "USER FAQ Question",
          'answer':
              "Lorem LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem"
        },
      ],
    );
  }
}

class TextFAQ extends StatelessWidget {
  final int index;
  final String question, answer;
  const TextFAQ({
    super.key,
    required this.index,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: SizeConfig.getPercentSize(2.5),
        left: SizeConfig.getPercentSize(2.5),
        right: SizeConfig.getPercentSize(2.5),
        bottom: SizeConfig.getPercentSize(2.5),
      ),
      padding: EdgeInsets.all(SizeConfig.getPercentSize(2.5)),
      decoration: BoxDecoration(
        color: ColorConstants.lightGreen,
        border: Border.all(
          color: ColorConstants.darkGreen,
          width: SizeConfig.getPercentSize(0.7),
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.getPercentSize(3),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.darkGreen,
            offset: Offset(
              SizeConfig.getPercentSize(1.0),
              SizeConfig.getPercentSize(1.0),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.getPercentSize(1.0)),
            child: Text(
              "Q$index: $question",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorConstants.darkGreen,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.getPercentSize(1.0)),
            child: Text(
              "A: $answer",
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
