import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:kolos_app/dashed_divider.dart";
import "package:kolos_app/theme/colors.dart";
import "package:kolos_app/theme/text_styles.dart";
import "package:intl/intl.dart";
import "package:kolos_app/widgets/scale_question.dart";
import 'package:firebase_auth/firebase_auth.dart';


class CheckInScreen extends StatefulWidget{
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}


class _CheckInScreenState extends State<CheckInScreen> {
  int? sleepValue;
  int? muscleSoreness;
  int? energyLevel;
  int? mood;
  bool? hasPain;
  final TextEditingController painController = TextEditingController();

  bool get allAnswered  { 
        if( sleepValue == null || 
            muscleSoreness == null ||
            energyLevel == null ||
            mood == null ||
            hasPain == null){
        return false;
        }
        
        if (hasPain == true && painController.text.trim().isEmpty) {
            return false;
        }
        
        return true;

  }

Future<void> _handleSubmit() async {
    if (!allAnswered) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please answer all questions before submitting.",
                              style: TextStyle( color: AppColors.textOnAccent)),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                              ),
                            );
                            return;
                          }

final uid = FirebaseAuth.instance.currentUser!.uid;
final today = DateTime.now();
final dateId = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

try {
  await FirebaseFirestore.instance.collection('checkins').add({
    'playerUid': uid,
    'date': dateId,
    'submittedAt': FieldValue.serverTimestamp(),
    'sleep': sleepValue,
    'soreness': muscleSoreness,
    'energy': energyLevel,
    'mood': mood,
    'hasPain': hasPain,
    'painNote': hasPain == true ? painController.text.trim() : null,
  });

  if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text("Check-in submitted!"),
    duration: Duration(seconds: 1),
));
} catch (e) {
  if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong: $e")),
    );
    

}

}

@override
void initState() {
  super.initState();
  painController.addListener(() {
    setState(() {});
  });
}

  @override
  void dispose() {
    painController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d', 'en_US').format(today);


    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DAILY CHECK-IN", style: AppTextStyles.displaySmall),
                        
                        const SizedBox(height: 4,),
                        
                        Text("How are you feeling today?", style: AppTextStyles.displayLarge),
                        
                        const SizedBox(height: 12),
                        
                        Text(formattedDate, style: AppTextStyles.muted),
                        
                        const SizedBox(height: 16),
                        
                        const DashedDivider(),
                        
                        const SizedBox(height: 12),
                        
                        ScaleQuestion(
                          label: "Sleep", 
                          hint: "How rested do you feel?", 
                          value: sleepValue, 
                          onChanged: (v) => setState(() => sleepValue = v)
                          ),
                          
                          const SizedBox(height: 12),
                        
                        ScaleQuestion(
                          label: "Muscle soreness", 
                          hint: "How heavy does your body feel?", 
                          value: muscleSoreness, 
                          onChanged: (v) => setState(() => muscleSoreness = v)),
                          
                          const SizedBox(height: 12),
                          
                          ScaleQuestion(
                          label: "Energy", 
                          hint: "How energetic do you feel today?", 
                          value: energyLevel, 
                          onChanged: (v) => setState(() => energyLevel = v)),

                          const SizedBox(height: 12),

                          ScaleQuestion(
                          label: "Mood", 
                          hint: "How are you feeling emotionally?", 
                          value: mood, 
                          onChanged: (v) => setState(() => mood = v)),

                          const SizedBox(height: 20),

                          const DashedDivider(),

                          const SizedBox(height: 20),

                          Text("Any pain or injury?", 
                          style: AppTextStyles.questionLabel),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => hasPain = false),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(vertical: 11),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: hasPain == false ? AppColors.accent : AppColors.surface,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: hasPain == false ? Colors.white : AppColors.border,
                                      ),
                                    ),
                                  child: Text("No",
                                  style: AppTextStyles.scaleNumber.copyWith(
                                    color: hasPain == false 
                                    ? AppColors.background
                                    : AppColors.textMuted, 
                                  ),
                                ),  
                              ),
                            ), 
                          ),

                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => hasPain = true),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 11),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: hasPain == true ? AppColors.statusCaution : AppColors.surface,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: hasPain == true ? AppColors.statusCaution : AppColors.border,
                                  )                                
                                ),
                                child: Text("Yes",
                                style: AppTextStyles.scaleNumber.copyWith(
                                  color: hasPain == true ? AppColors.background : AppColors.textMuted,
                                ),),
                              ),

                            )
                          )
                        ],
                      ),
                      
                      const SizedBox(height: 12),

                      if (hasPain == true) ...[

                        const SizedBox(height: 12),

                        TextField(
                          
                          controller: painController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Where does it hurt?",
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: AppColors.surface,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.border),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ],


                      const SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: allAnswered ? Colors.white : AppColors.surface,
                          foregroundColor: allAnswered ? AppColors.background : AppColors.textMuted,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      child: const Text("Submit check-in"),
                  ),

                  const SizedBox(height: 12)


                      ],//children
                    ) 
                  ),
                )
              )
            );
          }
        ),
      )
    );
  }
}
