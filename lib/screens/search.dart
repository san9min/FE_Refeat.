import 'package:flutter/material.dart';
import 'package:researchtool/main.dart';
import 'package:shimmer/shimmer.dart';

import 'package:researchtool/widget/placeholder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.login, required this.searchQuery})
      : super(key: key);

  final bool login;
  final String searchQuery;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool login = false;
  List<bool> selectedRows = List.generate(10, (index) => false);
  TextEditingController searchQureyController = TextEditingController();
  bool result = false;
  @override
  void initState() {
    // TODO: implement initState
    login = widget.login;
    searchQureyController.text = widget.searchQuery;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        result = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            drawerEnableOpenDragGesture: false,
            backgroundColor: const Color.fromARGB(
                255, 36, 36, 36), // const Color.fromRGBO(30, 34, 42, 1),
            appBar: AppBar(
              toolbarHeight: 84,
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      MyFluroRouter.router.navigateTo(context, "/");
                    },
                    child: const Image(
                      height: 28,
                      image: AssetImage('assets/images/weblogo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 46, 50, 52),
                            borderRadius: BorderRadius.circular(8)),
                        height: 48,
                        width: width > 700 ? width / 2.5 : width / 1.5,
                        child: searchResultWidget()),
                  )
                ],
              ),
              backgroundColor: const Color(0x44000000),
              elevation: 0,
            ),
            body: !result
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width > 700 ? 224.0 : 24,
                      vertical: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade500,
                            enabled: true,
                            child: const SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TitlePlaceholder(width: 128),
                                  SizedBox(height: 16.0),
                                  ContentPlaceholder(
                                    lineType: ContentLineType.threeLines,
                                  ),
                                  // ContentPlaceholder(
                                  //   lineType: ContentLineType.threeLines,
                                  // ),
                                  // SizedBox(height: 16.0),
                                  // TitlePlaceholder(width: 200.0),
                                  // SizedBox(height: 16.0),
                                  // ContentPlaceholder(
                                  //   lineType: ContentLineType.twoLines,
                                  // ),
                                  // SizedBox(height: 16.0),
                                  // TitlePlaceholder(width: 200.0),
                                  // SizedBox(height: 16.0),
                                  // ContentPlaceholder(
                                  //   lineType: ContentLineType.twoLines,
                                  // ),
                                  BannerPlaceholder(),
                                ],
                              ),
                            )),
                      ],
                    ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width > 700 ? 224.0 : 24,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("✨ 인사이트",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 8,
                          ),
                          //   Shimmer.fromColors(

                          //     child:

                          // TitlePlaceholder(width: double.infinity),
                          // SizedBox(height: 16.0),
                          // ContentPlaceholder(
                          //   lineType: ContentLineType.threeLines,
                          // ),
                          //     ,
                          //   ),
                          const Text('''
국내에서는 친환경차(전기, 수소, 하이브리드) 등록 대수가 전년 대비 37.2% 증가하여 자동차 시장에서 6.2%를 차지했습니다. 전기차는 68.4% 증가하고 수소차는 52.7% 증가하며, 반면 휘발유차는 2.6% 증가하고 경유차와 LPG차는 각각 1.2%와 2.1% 감소했습니다. 국내 자동차 보유 대수는 0.5대로, 승용차와 화물차는 증가하고 승합차는 감소했습니다. 국산차가 수입차보다 점유율이 높아지고 있습니다.
해외에서는 전기 자동차 시장이 급속한 성장을 보이고 있으며, 미국에서는 2030년까지 전체 판매량의 약 29.5%를 차지할 것으로 예상됩니다. 전세계 시장 규모도 2030년까지 9519억 달러로 성장할 것으로 전망되며 연평균 성장률은 13.7%로 예측됩니다.
            ''',
                              style: TextStyle(
                                color: Colors.white70,
                              )),
                          Container(
                            height: MediaQuery.of(context).size.height / 1,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        '내 프로젝트에 자료 추가하기',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.2,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      columnSpacing: 12,
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 46, 50, 52),
                                      ),
                                      headingRowHeight: 32,
                                      dataRowMinHeight: 84,
                                      dataRowMaxHeight: 84,
                                      horizontalMargin: 12,
                                      dataTextStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      border: TableBorder.symmetric(
                                          inside: BorderSide(
                                              color: Colors.grey.shade700)),
                                      columns: [
                                        DataColumn(
                                            label: SizedBox(
                                          width: width / 4,
                                          child: const Text(
                                            '자료',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                        DataColumn(
                                            label: SizedBox(
                                          width: width / 2,
                                          child: const Text('내용',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        )),
                                      ],
                                      rows: List<DataRow>.generate(
                                        10, // 행의 수를 조정하세요.
                                        (index) => DataRow(
                                          selected: selectedRows[
                                              index], // 행 선택 상태를 반영합니다.
                                          onSelectChanged: (selected) {
                                            setState(() {
                                              selectedRows[index] = selected!;
                                            });
                                          },
                                          cells: [
                                            DataCell(
                                              SizedBox(
                                                width: width / 4.2,
                                                child: dataUI(
                                                    "국내 친환경차 누적 150만대 돌파…전기차 전년 대비 68.4% ↑",
                                                    "https://kostat.go.kr/img/logo/favicon.png",
                                                    "https://www.korea.kr/news/policyNewsView.do?newsId=148910922",
                                                    width),
                                              ),
                                              placeholder: true,
                                            ),
                                            DataCell(SizedBox(
                                              width: width / 2.5,
                                              child: const Text(
                                                '작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와...',
                                                softWrap: true,
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: PlutoGrid(
                          //     createHeader: (s) => InkWell(
                          //       onTap: () {
                          //         setState(() {
                          //           mode = mode.isNormal == true
                          //               ? PlutoGridMode.readOnly
                          //               : PlutoGridMode.normal;
                          //         });
                          //       },
                          //       child: Container(
                          //           padding: const EdgeInsets.all(8),
                          //           margin: const EdgeInsets.all(12.0),
                          //           decoration: BoxDecoration(
                          //             color: Colors.blueAccent,
                          //             borderRadius: BorderRadius.circular(4),
                          //           ),
                          //           child: const Text(
                          //             '내 프로젝트에 자료 추가하기',
                          //             style: TextStyle(color: Colors.white),
                          //           )),
                          //     ),
                          //     configuration: PlutoGridConfiguration(
                          //         columnSize: const PlutoGridColumnSizeConfig(
                          //             resizeMode: PlutoResizeMode.none,
                          //             autoSizeMode: PlutoAutoSizeMode.equal),
                          //         style: PlutoGridStyleConfig(
                          //             iconColor: Colors.grey,
                          //             menuBackgroundColor: Colors.blue,
                          //             columnTextStyle:
                          //                 const TextStyle(color: Colors.white),
                          //             cellTextStyle:
                          //                 const TextStyle(color: Colors.white),
                          //             gridBackgroundColor: Colors.transparent,
                          //             gridBorderRadius: BorderRadius.circular(10),
                          //             activatedColor: Colors.transparent,
                          //             activatedBorderColor: Colors.white,
                          //             rowColor: Colors.transparent)),
                          //     onRowChecked: (selected) {},
                          //     columns: columns,
                          //     rows: rows,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )));
  }

  Widget searchResultWidget() {
    return TextField(
      onSubmitted: (text) {
        String encodedText = Uri.encodeComponent(text);
        Navigator.of(context).pushNamed("/search?q=$encodedText");
      },
      controller: searchQureyController,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
          hintText: "필요한 자료를 찾아보세요",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          icon: Padding(
              padding: EdgeInsets.only(left: 13),
              child: Icon(Icons.search, color: Colors.grey))),
    );
  }
}

// List<PlutoColumn> columns = [
//   /// Text Column definition
//   PlutoColumn(
//     title: '자료',
//     field: 'data_field',
//     type: PlutoColumnType.text(),
//     backgroundColor: const Color.fromARGB(255, 46, 50, 52),
//     enableRowChecked: true,
//     enableEditingMode: false,
//     enableContextMenu: false,
//     enableSorting: false,
//     enableDropToResize: false,
//     enableColumnDrag: false,
//   ),

//   /// Number Column definition
//   PlutoColumn(
//     title: '내용',
//     field: 'contents_field',
//     type: PlutoColumnType.text(),
//     enableHideColumnMenuItem: false,
//     backgroundColor: const Color.fromARGB(255, 46, 50, 52),
//     enableEditingMode: false,
//     enableContextMenu: false,
//     enableSorting: false,
//     enableDropToResize: false,
//     enableColumnDrag: false,
//   ),
// ];

// List<PlutoRow> rows = [
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(
//           value: dataUI(
//               "국내 친환경차 누적 150만대 돌파…전기차 전년 대비 68.4% ↑",
//               "https://kostat.go.kr/img/logo/favicon.png",
//               "https://www.korea.kr/news/policyNewsView.do?newsId=148910922")),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value1'),
//       'contents_field': PlutoCell(
//           value:
//               "작년에 국내 친환경차 등록 대수가 40% 증가하여 150만대를 돌파했고, 전체 자동차 등록 대수는 2.4% 증가한 2550만대를 기록했습니다. 국산차가 점유율의 87.5%를 차지하며, 친환경차는 6.2%를 차지하고 있습니다. 휘발유차는 증가하고 경유차와..."),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'data_field': PlutoCell(value: 'Text cell value2'),
//       'contents_field': PlutoCell(
//           value:
//               "이 보고서는 전기 자동차 및 충전 인프라 배치, 에너지 사용, 이산화탄소 배출, 배터리 수요 및 관련 정책 개발과 같은 주요 관심 분야를 조망하며 역사적 분석과 2030년까지의 예측을 결합합니다. 이 보고서는 주요 시장에서 얻은 교훈을 토대로 정책 결정..."),
//     },
//   ),
// ];

Widget dataUI(String title, String favicon, String url, double width) {
  return Row(children: [
    Image.network(
      "https://kostat.go.kr/img/logo/favicon.png",
      height: 24,
    ),
    const SizedBox(
      width: 12,
    ),
    SizedBox(
      width: width / 5,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "국내 친환경차 누적 150만대 돌파…전기차 전년 대비 68.4% ↑",
            softWrap: true,
            style: TextStyle(color: Colors.white, overflow: TextOverflow.clip),
          ),
          Text("https://www.korea.kr/news/policyNewsView.do?newsId=148910922",
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    ),
  ]);
}
