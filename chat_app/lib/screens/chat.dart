import 'package:flutter/foundation.dart';
import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  XFile? _pickedImage;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImage = pickedImage;
    });

    _submitMessage();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty && _pickedImage == null) {
      return;
    }

    _messageController.clear();
    if (!mounted) {
      return;
    }
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser!;
    String? imageUrl;

    if (_pickedImage != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      if (kIsWeb) {
        await storageRef.putData(await _pickedImage!.readAsBytes());
      } else {
        await storageRef.putFile(File(_pickedImage!.path));
      }
      imageUrl = await storageRef.getDownloadURL();

      if (!mounted) {
        return;
      }

      setState(() {
        _pickedImage = null;
      });
    }

    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': user.email,
      'userImage': user.photoURL,
      'image_url': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshots) {
                if (chatSnapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!chatSnapshots.hasData ||
                    chatSnapshots.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages found.'));
                }
                if (chatSnapshots.hasError) {
                  return const Center(child: Text('Something went wrong...'));
                }
                final loadedMessages = chatSnapshots.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                    left: 13,
                    right: 13,
                  ),
                  reverse: true,
                  itemCount: loadedMessages.length,
                  itemBuilder: (ctx, index) {
                    final chatMessage = loadedMessages[index].data();
                    final nextChatMessage = index + 1 < loadedMessages.length
                        ? loadedMessages[index + 1].data()
                        : null;
                    final currentMessageUserId = chatMessage['userId'];
                    final nextMessageUserId = nextChatMessage != null
                        ? nextChatMessage['userId']
                        : null;
                    final nextUserIsSame =
                        nextMessageUserId == currentMessageUserId;

                    if (nextUserIsSame && chatMessage['image_url'] == null) {
                      return MessageBubble.next(
                        message: chatMessage['text'],
                        isMe:
                            currentMessageUserId ==
                            FirebaseAuth.instance.currentUser!.uid,
                      );
                    } else {
                      return MessageBubble.first(
                        userImage: chatMessage['userImage'],
                        username: chatMessage['username'],
                        message: chatMessage['text'],
                        imageUrl: chatMessage['image_url'],
                        isMe:
                            currentMessageUserId ==
                            FirebaseAuth.instance.currentUser!.uid,
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
            child: Row(
              children: [
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      labelText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.send),
                  onPressed: _submitMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble.first({
    super.key,
    this.userImage,
    required this.username,
    required this.message,
    this.imageUrl,
    required this.isMe,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = false,
       userImage = null,
       username = null,
       imageUrl = null;

  final bool isFirstInSequence;
  final String? userImage;
  final String? username;
  final String message;
  final String? imageUrl;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            right: isMe ? 120 : null,
            left: isMe ? null : 120,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage!),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey.shade300
                          : theme.colorScheme.secondary.withAlpha(200),
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (imageUrl != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              width: 150,
                            ),
                          ),
                        if (message.isNotEmpty)
                          Text(
                            message,
                            style: TextStyle(
                              height: 1.3,
                              color: isMe
                                  ? Colors.black87
                                  : theme.colorScheme.onSecondary,
                            ),
                            softWrap: true,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
