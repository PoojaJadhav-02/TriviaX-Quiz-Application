import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../quiz/models/custom_question_model.dart';
import '../providers/custom_quiz_provider.dart';

class AddEditQuestionScreen extends ConsumerStatefulWidget {
  const AddEditQuestionScreen({super.key});

  @override
  ConsumerState<AddEditQuestionScreen> createState() => _AddEditQuestionScreenState();
}

class _AddEditQuestionScreenState extends ConsumerState<AddEditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionCtrl = TextEditingController();
  final _optACtrl = TextEditingController();
  final _optBCtrl = TextEditingController();
  final _optCCtrl = TextEditingController();
  final _optDCtrl = TextEditingController();

  String? _correctAnswer;
  CustomQuestionModel? _editing;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is CustomQuestionModel) {
      _editing = arg;
      _isEdit = true;
      _questionCtrl.text = arg.question;
      _optACtrl.text = arg.optionA;
      _optBCtrl.text = arg.optionB;
      _optCCtrl.text = arg.optionC;
      _optDCtrl.text = arg.optionD;
      _correctAnswer = arg.correctAnswer;
    }
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    _optACtrl.dispose();
    _optBCtrl.dispose();
    _optCCtrl.dispose();
    _optDCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_correctAnswer == null) {
      _showSnack('Please select the correct answer');
      return;
    }

    final model = CustomQuestionModel(
      id: _editing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      question: _questionCtrl.text.trim(),
      optionA: _optACtrl.text.trim(),
      optionB: _optBCtrl.text.trim(),
      optionC: _optCCtrl.text.trim(),
      optionD: _optDCtrl.text.trim(),
      correctAnswer: _correctAnswer!,
    );

    final notifier = ref.read(customQuizProvider.notifier);
    if (_isEdit && _editing != null) {
      notifier.updateQuestion(_editing!.id, model);
    } else {
      notifier.addQuestion(model);
    }

    Get.back();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.poppins()),
        backgroundColor: AppColors.wrong,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final options = [
      ('A', _optACtrl),
      ('B', _optBCtrl),
      ('C', _optCCtrl),
      ('D', _optDCtrl),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [const Color(0xFFEDE9FE), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.glassLight,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: isDark ? Colors.white : AppColors.gradientStart,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      _isEdit ? 'Edit Question' : 'Add Question',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppColors.gradientStart,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const SizedBox(height: 8),

                      // Question field
                      _SectionLabel('Question'),
                      _buildField(
                        controller: _questionCtrl,
                        hint: 'Enter your question...',
                        minLines: 2,
                        maxLines: 4,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Question cannot be empty'
                            : null,
                      ),

                      const SizedBox(height: 24),
                      _SectionLabel('Answer Options'),
                      const SizedBox(height: 8),

                      // Option fields
                      ...options.asMap().entries.map((e) {
                        final _ = e.key;
                        final label = e.value.$1;
                        final ctrl = e.value.$2;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildField(
                            controller: ctrl,
                            hint: 'Option $label',
                            prefix: label,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Option $label cannot be empty'
                                : null,
                            onChanged: (_) => setState(() {}),
                          ),
                        );
                      }),

                      const SizedBox(height: 16),
                      _SectionLabel('Correct Answer'),
                      const SizedBox(height: 8),

                      // Correct answer selector
                      StatefulBuilder(
                        builder: (_, setLocal) {
                          final currentOpts = [
                            _optACtrl.text.trim(),
                            _optBCtrl.text.trim(),
                            _optCCtrl.text.trim(),
                            _optDCtrl.text.trim(),
                          ];
                          return Column(
                            children: List.generate(4, (i) {
                              final letters = ['A', 'B', 'C', 'D'];
                              final val = currentOpts[i];
                              final isEmpty = val.isEmpty;
                              return GestureDetector(
                                onTap: isEmpty
                                    ? null
                                    : () => setState(() => _correctAnswer = val),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: _correctAnswer == val && !isEmpty
                                        ? AppColors.easyColor.withValues(alpha: 0.2)
                                        : AppColors.glassLight,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _correctAnswer == val && !isEmpty
                                          ? AppColors.easyColor
                                          : AppColors.glassBorder,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        _correctAnswer == val && !isEmpty
                                            ? Icons.check_circle_rounded
                                            : Icons.radio_button_unchecked_rounded,
                                        color: _correctAnswer == val && !isEmpty
                                            ? AppColors.easyColor
                                            : AppColors.textMuted,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        isEmpty ? 'Option ${letters[i]} (fill above)' : val,
                                        style: GoogleFonts.poppins(
                                          color: isEmpty
                                              ? AppColors.textMuted
                                              : (_correctAnswer == val
                                                  ? AppColors.easyColor
                                                  : Colors.white),
                                          fontSize: 14,
                                          fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton.icon(
                        onPressed: _submit,
                        icon: Icon(_isEdit ? Icons.save_rounded : Icons.add_rounded),
                        label: Text(
                          _isEdit ? 'Save Changes' : 'Add Question',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 4,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    String? prefix,
    int minLines = 1,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: AppColors.textMuted),
        prefixText: prefix != null ? '  $prefix  ' : null,
        prefixStyle: GoogleFonts.poppins(
          color: AppColors.primaryLight,
          fontWeight: FontWeight.w700,
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05);
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: AppColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}