import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_markdown_selectionarea/flutter_markdown_selectionarea.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
import 'package:provider/provider.dart';
import 'package:researchtool/api/project.dart';
import 'package:researchtool/model/dratf.dart';

// import 'dart:math' as math;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';

class Draft extends StatefulWidget {
  const Draft({
    Key? key,
    required this.draft,
    required this.isTrained,
    required this.draftId,
    required this.projectName,
  }) : super(key: key);
  final int draftId;
  final String draft;
  final String projectName;
  final bool isTrained;
  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<
    Draft> //with TextSelectionDelegate, TextInputClient, DeltaTextInputClient
{
  bool isfirst = true;
  bool _loading = false;
  Timer? blinkingTimer;
  bool copyComplete = false;
  //
  late String selectedText = "";

  late FocusNode _selectionFocusNode;

  bool isEdit = false;
  final textcontroller = TextEditingController();
  ScrollController markdownscroll = ScrollController();
  late final FocusNode markdownFocusnode;
  TextEditingController markdownController = TextEditingController();

  int chatId = -1;

  @override
  void initState() {
    super.initState();
    markdownController.addListener(() => setState(() {}));
    markdownFocusnode = FocusNode();

    _selectionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textcontroller.dispose();
    markdownController.dispose();
    markdownFocusnode.dispose();

    _selectionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<DraftModel>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectionArea(
            onSelectionChanged: (value) {
              selectedText = value?.plainText ?? "";
            },
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // 그림자 색상과 불투명도
                      spreadRadius: 5, // 그림자의 확산 범위
                      blurRadius: 10, // 그림자의 흐릿함 정도
                      offset: const Offset(0, 3), // 그림자의 위치 (가로, 세로)
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromARGB(255, 36, 36, 36),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                color: const Color.fromARGB(255, 36, 36, 36),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            provider.isTrained
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                        height: 24,
                                      ),
                                      const Icon(Icons.circle,
                                          color: Colors.cyan, size: 14),
                                      const Icon(Icons.circle,
                                          color: Colors.lightBlue, size: 14),
                                      Icon(Icons.circle,
                                          color: Colors.indigo.shade700,
                                          size: 14),
                                    ],
                                  )
                                : JumpingDots(
                                    numberOfDots: 3,
                                    color: Colors.grey,
                                    verticalOffset: -5,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                  ),
                            !provider.isTrained
                                ? Container()
                                : isEdit
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: width > 700
                                                    ? double.infinity
                                                    : 224),
                                            child: MarkdownToolbar(
                                              height: 24,
                                              width: 24,
                                              iconSize: 18,
                                              dropdownTextColor: Colors.black,
                                              useIncludedTextField: false,
                                              controller: markdownController,
                                              focusNode: markdownFocusnode,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                  onTap: () {
                                                    provider.setDraft(
                                                        markdownController.text,
                                                        widget.draftId);
                                                    setState(() {
                                                      isEdit = false;
                                                    });
                                                  },
                                                  child: const Icon(Icons.check,
                                                      color: Colors.lightBlue,
                                                      size: 24))),
                                          const SizedBox(width: 12),
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      markdownController.text =
                                                          provider.draft;
                                                      isEdit = true;
                                                    });
                                                  },
                                                  child: const Icon(Icons.edit,
                                                      color: Colors.white,
                                                      size: 22))),
                                          const SizedBox(width: 12),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      _loading = true;
                                                    });
                                                    await provider.reGenDraft(
                                                        widget.draftId);
                                                    setState(() {
                                                      _loading = false;
                                                    });
                                                  },
                                                  child: const Icon(
                                                      Icons.refresh,
                                                      color: Colors.white,
                                                      size: 24))),
                                          const SizedBox(width: 12),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                  onTap: () {
                                                    provider.copyDraft(
                                                        provider.draft);
                                                  },
                                                  child: Icon(
                                                      provider.isCopied
                                                          ? Icons.check
                                                          : Icons.copy,
                                                      color: Colors.white,
                                                      size: 22))),
                                          const SizedBox(width: 12),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                  onTap: () async {
                                                    ProjectAPI.downloadDraft(
                                                        widget.draftId,
                                                        widget.projectName);
                                                    // if (await canLaunchUrl(
                                                    //     link)) {
                                                    //   await launchUrl(
                                                    //       link); // URL을 엽니다.
                                                    // } else {
                                                    //   throw 'Could not launch $link';
                                                    // }
                                                  },
                                                  child: const Icon(
                                                      Icons.download,
                                                      color: Colors.white,
                                                      size: 22))),
                                          const SizedBox(width: 12),
                                        ],
                                      )
                          ]),
                    ),
                    // const Divider(
                    //   color: Colors.grey,
                    //   thickness: 2,
                    //   height: 2,
                    // ),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 46, 50, 52),
                          ),
                          child: content(provider.draft)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.only(top: 10),
          //   constraints: const BoxConstraints(
          //     maxHeight: 224,
          //   ),
          //   width: double.infinity,
          //   child: SingleChildScrollView(
          //     reverse: true,
          //     child: Column(
          //       children: [
          //         Container(
          //           height: 12,
          //           color: Colors.transparent,
          //         ),
          //         Row(
          //           children: [
          //             SizedBox(
          //               width: width > 700 ? width / 9 : width / 36,
          //             ),
          //             Expanded(
          //               child: SingleChildScrollView(
          //                 reverse: true,
          //                 child: Container(
          //                   constraints: const BoxConstraints(maxHeight: 90),
          //                   child: TextField(
          //                     autofocus: true,
          //                     enabled: provider.isTrained,
          //                     onSubmitted: (text) async {
          //                       if (!_loading) {
          //                         textcontroller.clear();
          //                         provider.editDraftwithAI(
          //                             widget.draftId, text, selectedText);
          //                       }
          //                     },
          //                     textInputAction: TextInputAction.go,
          //                     cursorColor: Colors.grey,
          //                     controller: textcontroller,
          //                     style: const TextStyle(color: Colors.white),
          //                     decoration: InputDecoration(
          //                       focusedBorder: OutlineInputBorder(
          //                         borderSide: const BorderSide(
          //                           color: Colors.grey,
          //                           width: 1.0,
          //                         ),
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                       hintText: provider.isTrained
          //                           ? "수정하고 싶으신 부분을 드래그 후 AI에게 요청해보세요"
          //                           : provider.embeddingComplete
          //                               ? "아직 초안을 작성 중이에요!"
          //                               : "자료들을 학습하고 있어요!",
          //                       hintStyle:
          //                           TextStyle(color: Colors.grey.shade600),
          //                       border: OutlineInputBorder(
          //                         borderSide: const BorderSide(
          //                           color: Colors.grey,
          //                           width: 1.0,
          //                         ),
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                       enabledBorder: OutlineInputBorder(
          //                         borderSide: const BorderSide(
          //                           color: Colors.grey,
          //                           width: 1.0,
          //                         ),
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(
          //               width: 15,
          //             ),
          //             ElevatedButton(
          //               onPressed: _loading || !provider.isTrained
          //                   ? null
          //                   : () {
          //                       final text = textcontroller.text;

          //                       if (selectedText.isEmpty) {
          //                       } else {
          //                         textcontroller.clear();
          //                         provider.editDraftwithAI(
          //                             widget.draftId, text, selectedText);
          //                       }
          //                     },
          //               style: ElevatedButton.styleFrom(
          //                 minimumSize: const Size(50, 50),
          //                 backgroundColor: Colors.transparent,
          //                 shape: RoundedRectangleBorder(
          //                   side: BorderSide(
          //                       color: provider.isTrained
          //                           ? Colors.grey
          //                           : Colors.transparent),
          //                   borderRadius:
          //                       BorderRadius.circular(10), // 모서리를 둥글게 조정
          //                 ),
          //               ),
          //               child: Icon(
          //                 Icons.send,
          //                 color: _loading || !provider.isTrained
          //                     ? Colors.grey
          //                     : Colors.white,
          //                 size: 18,
          //               ),
          //             ),
          //             SizedBox(width: width > 700 ? width / 9 : width / 36),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      );
    });
  }

  Widget content(message) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: isEdit
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      maxLines: 500,
                      style: const TextStyle(color: Colors.white),
                      controller: markdownController, // Add the _controller
                      focusNode: markdownFocusnode, // Add the _focusNode
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 46, 50, 52),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width > 700 ? 64.0 : 24,
                    vertical: 8.0),
                child: Markdown(
                  controller: markdownscroll,
                  data: message,
                  padding: const EdgeInsets.symmetric(
                      vertical: 48.0, horizontal: 64),
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: Colors.white70),
                    tableBody: const TextStyle(color: Colors.white),
                    tableHead: const TextStyle(color: Colors.white),
                    tableBorder: TableBorder.all(color: Colors.white),
                    h1: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    h1Padding: const EdgeInsets.symmetric(vertical: 20),
                    h2: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    h2Padding: const EdgeInsets.symmetric(vertical: 14),
                    h3: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    h3Padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ));
  }

  //State 끝
}
