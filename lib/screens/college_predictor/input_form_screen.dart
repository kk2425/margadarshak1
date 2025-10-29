
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/constants.dart';
import '../../models/college_models.dart';
import '../../providers/college_provider.dart';
import 'prediction_result_screen.dart';

class InputFormScreen extends ConsumerStatefulWidget {
  const InputFormScreen({super.key});

  @override
  ConsumerState<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends ConsumerState<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scoreController = TextEditingController();
  final _rankController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with existing values if any
    final score = ref.read(mhcetScoreProvider);
    final rank = ref.read(rankProvider);
    _scoreController.text = score;
    _rankController.text = rank;
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _rankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryProvider);
    final quota = ref.watch(quotaProvider);
    final selectedBranches = ref.watch(selectedBranchesProvider);
    final selectedLocations = ref.watch(selectedLocationsProvider);
    final isFormValid = ref.watch(formValidProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'College Predictor',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Score Input
              const Text(
                'Your MH-CET Score',
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter score (0-200)',
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  ref.read(mhcetScoreProvider.notifier).state = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your score';
                  }
                  final score = int.tryParse(value);
                  if (score == null || score < 0 || score > 200) {
                    return 'Score must be between 0 and 200';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Rank Input
              const Text(
                'Your MH-CET Rank',
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _rankController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: 'Enter rank',
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  ref.read(rankProvider.notifier).state = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your rank';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid rank';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Category Selection
              const Text(
                'Select your category',
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['OPEN', 'OBC', 'SC', 'ST', 'VJ/DT', 'NT-B', 'NT-C', 'NT-D', 'SBC'].map((cat) {
                  final isSelected = category == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(categoryProvider.notifier).state = cat;
                      }
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.backgroundLight,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // Branch Preferences
              const Text(
                'Select branch preferences',
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Computer', 'IT', 'AI & DS', 'ENTC', 'Mechanical', 'Civil'].map((branch) {
                  final isSelected = selectedBranches.contains(branch);
                  return FilterChip(
                    label: Text(branch),
                    selected: isSelected,
                    onSelected: (selected) {
                      final current = List<String>.from(selectedBranches);
                      if (selected) {
                        current.add(branch);
                      } else {
                        current.remove(branch);
                      }
                      ref.read(selectedBranchesProvider.notifier).state = current;
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.backgroundLight,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    checkmarkColor: Colors.white,
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // Quota Type
              const Text(
                'Quota Type',
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: quota,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  items: ['All India', 'Home University', 'Other Than Home University'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(quotaProvider.notifier).state = value;
                    }
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Location Preferences (Optional)
              const Text(
                'Preferred Locations (Optional)',
                style: AppTextStyles.headingSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Pune', 'Mumbai', 'Nagpur', 'Aurangabad', 'Nashik'].map((location) {
                  final isSelected = selectedLocations.contains(location);
                  return FilterChip(
                    label: Text(location),
                    selected: isSelected,
                    onSelected: (selected) {
                      final current = List<String>.from(selectedLocations);
                      if (selected) {
                        current.add(location);
                      } else {
                        current.remove(location);
                      }
                      ref.read(selectedLocationsProvider.notifier).state = current;
                    },
                    selectedColor: AppColors.secondary,
                    backgroundColor: AppColors.backgroundLight,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    checkmarkColor: Colors.white,
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 40),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            final input = PredictionInput(
                              mhcetScore: int.parse(_scoreController.text),
                              rank: int.parse(_rankController.text),
                              category: category,
                              branchPreferences: selectedBranches,
                              locationPreferences: selectedLocations,
                              quota: quota,
                            );
                            
                            ref.read(predictionInputProvider.notifier).state = input;
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PredictionResultScreen(),
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Predict My Colleges',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
