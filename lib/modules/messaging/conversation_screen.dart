import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/messaging/bloc/conv_bloc.dart';
import 'package:educately_chat/modules/messaging/models/message_model.dart';
import 'package:educately_chat/modules/messaging/widgets/conv_message_widget.dart';
import 'package:educately_chat/modules/messaging/widgets/convo_bottom_controls.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late ConvBloc bloc;
  @override
  void initState() {
    bloc = ConvBloc.of(context);
    bloc.add(const ConvInitEvent("test"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConvBloc, ConvState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(context),
          // backgroundColor: ,
          body: Container(
            width: context.width,
            height: context.height,
            decoration: _getBackgroundDecoration(),
            child: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is ConvLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ConvError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      return _buildMsgs(context, bloc.messages);
                    },
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                const ConvoBottomControls(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMsgs(BuildContext context, List<MessageModel> msgs) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
          itemCount: msgs.length + 1,
          padding: EdgeInsets.zero,
          reverse: true,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
            height: 2.h,
          ),
          itemBuilder: (context, index) {
            // Extra padding so we can see the content behind the appBar
            if (index == msgs.length) {
              return SizedBox(
                height: 110.h,
              );
            }
            final msg = msgs[index];
            bool isSecondary = false;
            if (index != 0) {
              // if multiple consecutive messages from same user don't show
              // name or photo
              if (msgs[index - 1].sender.uid == msg.sender.uid) {
                isSecondary = true;
              }
            }
            return MessageWidget(
              message: msg,
              isSecondary: isSecondary,
              // status: status,
            );
          },
        ),
      ),
    );
  }

  BoxDecoration _getBackgroundDecoration() {
    return BoxDecoration(
      color: AppColors.isDarkMode ? AppColors.scaffold : null,
      gradient: AppColors.isDarkMode
          ? null
          : LinearGradient(
              colors: [
                Colors.green.shade200,
                Colors.green,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: AppColors.appBar,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // TODO (abdelaziz): Goback
            },
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  bloc.title,
                  style: context.textTheme.s18.w800,
                ),
                Text(
                  bloc.subtitle,
                  style: context.textTheme.s14.w400.setColor(AppColors.subtext),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: bloc.photo == ""
                ? null
                : Image.network(
                    bloc.photo,
                    width: 37.r,
                    height: 37.r,
                    fit: BoxFit.cover,
                  ),
          )
        ],
      ),
    );
    if (!AppColors.isDarkMode) {
      return appBar;
    }
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        50.0.h,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: appBar,
        ),
      ),
    );
  }
}
