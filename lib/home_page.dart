import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tag {
  final String name;

  Tag(this.name);
}

class TagController extends GetxController {
  Rx<TextEditingController> useHashTagsController =
      Rx<TextEditingController>(TextEditingController());
  RxList<String> tagSuggestions =
      RxList<String>(['Flutter', 'Dart', 'GetX', 'Mobile', 'Development']);

  RxList<Tag> selectedTags = RxList<Tag>([]);

  void addTag(String tagName) {
    selectedTags.add(Tag(tagName));
  }

  void removeTag(Tag tag) {
    selectedTags.remove(tag);
  }
}

class AutoSuggestTagsDemo extends StatelessWidget {
  const AutoSuggestTagsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: TagController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Auto Suggest Tags Demo'),
            ),
            body: Column(
              children: [
                TextField(
                  controller: controller.useHashTagsController.value,
                  decoration: const InputDecoration(
                    labelText: 'Add Tags',
                  ),
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    controller.addTag(value);
                  },
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: controller.selectedTags
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: Chip(
                            label: Text(tag.name),
                            onDeleted: () {
                              controller.removeTag(tag);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                controller.selectedTags.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: controller.tagSuggestions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.tagSuggestions[index]),
                              onTap: () {
                                controller
                                    .addTag(controller.tagSuggestions[index]);
                              },
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        });
  }
}
