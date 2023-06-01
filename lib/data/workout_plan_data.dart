import 'package:befit_v2/data/workout_model.dart';
import 'package:befit_v2/data/workout_tips_model.dart';

List<Workout> workoutBeginnerPlan = [
  Workout(isRelax: false, day: 1, dayDuration: "7 min", name: "Jumping\nJacks", gif: "assets/images/jumping-jacks.gif", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 1, dayDuration: "7 min", name: "Squats", gif: "assets/images/squats.gif", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 1, dayDuration: "7 min", name: "High\nPlank", gif: "assets/images/high-plank.gif", duration: "30 sec", reps: "4x", gifSize: 120, gifDuration: 1500),

  Workout(isRelax: true, day: 2),

  Workout(isRelax: false, day: 3, dayDuration: "12 min", name: "Knee\nPush-ups", gif: "assets/images/knee-pushups.gif", duration: "30 sec", reps: "5x", gifSize: 120, gifDuration: 1650),
  Workout(isRelax: false, day: 3, dayDuration: "12 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "30 sec", reps: "5x", gifSize: null, gifDuration: 4000),
  Workout(isRelax: false, day: 3, dayDuration: "12 min", name: "Mountain\nClimbers", gif: "assets/images/mountain-climbers.gif", duration: "30 sec", reps: "5x", gifSize: 120, gifDuration: 1800),

  Workout(isRelax: true, day: 4),

  Workout(isRelax: true, day: 5),

  Workout(isRelax: false, day: 6, dayDuration: "7 min", name: "High\nKnees", gif: "assets/images/high-knees.gif", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 3000),
  Workout(isRelax: false, day: 6, dayDuration: "7 min", name: "Inchworms", gif: "assets/images/inchworms.gif", duration: "30 sec", reps: "4x", gifSize: 120, gifDuration: 5000),
  Workout(isRelax: false, day: 6, dayDuration: "7 min", name: "Jump\nSquats", gif: "assets/images/jump-squats.gif", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 1700),

  Workout(isRelax: true, day: 7),

  Workout(isRelax: true, day: 8),

  Workout(isRelax: false, day: 9, dayDuration: "10 min", name: "Jumping\nJacks", gif: "assets/images/jumping-jacks.gif", duration: "1 min", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 9, dayDuration: "10 min", name: "Squats", gif: "assets/images/squats.gif", duration: "1 min", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 9, dayDuration: "10 min", name: "High\nPlank", gif: "assets/images/high-plank.gif", duration: "30 sec", reps: "3x", gifSize: 120, gifDuration: 1500),

  Workout(isRelax: true, day: 10),

  Workout(isRelax: false, day: 11, dayDuration: "7 min", name: "Knee\nPush-ups", gif: "assets/images/knee-pushups.gif", duration: "30 sec", reps: "4x", gifSize: 120, gifDuration: 1650),
  Workout(isRelax: false, day: 11, dayDuration: "7 min", name: "Backward\nLunges", gif: "assets/images/backward-lunges.gif", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 4000),
  Workout(isRelax: false, day: 11, dayDuration: "7 min", name: "4-count\nBurpees", gif: "assets/images/burpees.gif", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 5000),

  Workout(isRelax: true, day: 12),

  Workout(isRelax: false, day: 13, dayDuration: "12 min", name: "High\nKnees", gif: "assets/images/high-knees.gif", duration: "30 sec", reps: "5x", gifSize: null, gifDuration: 3000),
  Workout(isRelax: false, day: 13, dayDuration: "12 min", name: "Wall\nSit", gif: "assets/images/wall-sit.png", duration: "30 sec", reps: "5x", gifSize: 140, gifDuration: 3000),
  Workout(isRelax: false, day: 13, dayDuration: "12 min", name: "Bridge", gif: "assets/images/bridge.gif", duration: "30 sec", reps: "5x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: true, day: 14),

  Workout(isRelax: false, day: 15, dayDuration: "13 min", name: "Jumping\nJacks", gif: "assets/images/jumping-jacks.gif", duration: "1 min", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 15, dayDuration: "13 min", name: "Squats", gif: "assets/images/squats.gif", duration: "1 min", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 15, dayDuration: "13 min", name: "Low\nPlank", gif: "assets/images/low-plank.png", duration: "30 sec", reps: "4x", gifSize: null, gifDuration: 1500),

  Workout(isRelax: true, day: 16),

  Workout(isRelax: false, day: 17, dayDuration: "12 min", name: "Knee\nPush-ups", gif: "assets/images/knee-pushups.gif", duration: "30 sec", reps: "5x", gifSize: 120, gifDuration: 1650),
  Workout(isRelax: false, day: 17, dayDuration: "12 min", name: "High\nKnees", gif: "assets/images/high-knees.gif", duration: "30 sec", reps: "5x", gifSize: null, gifDuration: 3000),
  Workout(isRelax: false, day: 17, dayDuration: "12 min", name: "Bridge", gif: "assets/images/bridge.gif", duration: "30 sec", reps: "5x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: true, day: 18),

  Workout(isRelax: false, day: 19, dayDuration: "11 min", name: "4-count\nBurpees", gif: "assets/images/burpees.gif", duration: "1 min", reps: "4x", gifSize: null, gifDuration: 5000),
  Workout(isRelax: false, day: 19, dayDuration: "11 min", name: "Wall\nSit", gif: "assets/images/wall-sit.png", duration: "30 sec", reps: "4x", gifSize: 140, gifDuration: 3000),
  Workout(isRelax: false, day: 19, dayDuration: "11 min", name: "Tricep\nDips", gif: "assets/images/tricep-dips.gif", duration: "30 sec", reps: "4x", gifSize: 120, gifDuration: 1500),

  Workout(isRelax: true, day: 20),
  Workout(isRelax: true, day: 21),

  Workout(isRelax: false, day: 22, dayDuration: "14 min", name: "Jumping\nJacks", gif: "assets/images/jumping-jacks.gif", duration: "1 min", reps: "5x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 22, dayDuration: "14 min", name: "Jump\nSquats", gif: "assets/images/jump-squats.gif", duration: "30 sec", reps: "5x", gifSize: null, gifDuration: 1700),
  Workout(isRelax: false, day: 22, dayDuration: "14 min", name: "Low\nPlank", gif: "assets/images/low-plank.png", duration: "30 sec", reps: "5x", gifSize: null, gifDuration: 1500),

  Workout(isRelax: true, day: 23),

  Workout(isRelax: false, day: 24, dayDuration: "14 min", name: "High\nKnees", gif: "assets/images/high-knees.gif", duration: "30 sec", reps: "6x", gifSize: null, gifDuration: 3000),
  Workout(isRelax: false, day: 24, dayDuration: "14 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "30 sec", reps: "6x", gifSize: null, gifDuration: 4000),
  Workout(isRelax: false, day: 24, dayDuration: "14 min", name: "Inchworms", gif: "assets/images/inchworms.gif", duration: "30 sec", reps: "6x", gifSize: 120, gifDuration: 5000),

  Workout(isRelax: true, day: 25),
  Workout(isRelax: true, day: 26),

  Workout(isRelax: false, day: 27, dayDuration: "11 min", name: "Knee\nPush-ups", gif: "assets/images/knee-pushups.gif", duration: "1 min", reps: "4x", gifSize: 120, gifDuration: 1650),
  Workout(isRelax: false, day: 27, dayDuration: "11 min", name: "Wall\nSit", gif: "assets/images/wall-sit.png", duration: "30 sec", reps: "4x", gifSize: 140, gifDuration: 3000),
  Workout(isRelax: false, day: 27, dayDuration: "11 min", name: "Mountain\nClimbers", gif: "assets/images/mountain-climbers.gif", duration: "30 sec", reps: "4x", gifSize: 120, gifDuration: 1800),

  Workout(isRelax: true, day: 28),
];

List<Workout> workoutIntermediatePlan = [
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Push-ups", gif: "assets/images/push-ups.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Inverted\nRows", gif: "assets/images/inverted-rows.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1400),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Diamond\nPush-ups", gif: "assets/images/diamond-push-ups.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Squats\n(3 sec pause\nat the bottom)", gif: "assets/images/squats.gif", duration: "15 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "15 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "10 times", reps: "3x", gifSize: 140, gifDuration: 4000),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Lying\nLeg Raises", gif: "assets/images/lying-leg-raises.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 3000),
  Workout(isRelax: false, week: 1, dayDuration: "30-45 min", name: "Crunches", gif: "assets/images/crunches.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1700),


  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Push-ups", gif: "assets/images/push-ups.gif", duration: "∞ times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Inverted\nRows", gif: "assets/images/inverted-rows.gif", duration: "∞ times", reps: "4x", gifSize: 120, gifDuration: 1400),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Diamond\nPush-ups", gif: "assets/images/diamond-push-ups.gif", duration: "∞ times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Squats\n(3 sec pause\nat the bottom)", gif: "assets/images/squats.gif", duration: "20 times", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "∞ times", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "20 times", reps: "4x", gifSize: 140, gifDuration: 4000),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Lying\nLeg Raises", gif: "assets/images/lying-leg-raises.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 3000),
  Workout(isRelax: false, week: 2, dayDuration: "30-45 min", name: "Crunches", gif: "assets/images/crunches.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),

  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Medium-Width\nGrip Pull-ups", gif: "assets/images/pull-ups.gif", duration: "10 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Feet Elevated\nPush-Ups", gif: "assets/images/feet-elevated-push-ups.gif", duration: "10 times", reps: "4x", gifSize: 120, gifDuration: 1600),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Bulgarian\nSquats", gif: "assets/images/bulgarian-squats.gif", duration: "10 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Diamond\nPush-ups", gif: "assets/images/diamond-push-ups.gif", duration: "10 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Jump\nSquats", gif: "assets/images/jump-squats.gif", duration: "10 times", reps: "4x", gifSize: null, gifDuration: 1700),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "10 times", reps: "3x", gifSize: 140, gifDuration: 4000),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "∞ times", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Crunches", gif: "assets/images/crunches.gif", duration: "10 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 3, dayDuration: "30-45 min", name: "Hanging\nLeg Raises", gif: "assets/images/hanging-leg-raises.gif", duration: "10 times", reps: "4x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Medium-Width\nGrip Pull-ups", gif: "assets/images/pull-ups.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Feet Elevated\nPush-Ups", gif: "assets/images/feet-elevated-push-ups.gif", duration: "20 times", reps: "4x", gifSize: 120, gifDuration: 1600),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Bulgarian\nSquats", gif: "assets/images/bulgarian-squats.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Diamond\nPush-ups", gif: "assets/images/diamond-push-ups.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Jump\nSquats", gif: "assets/images/jump-squats.gif", duration: "15 times", reps: "4x", gifSize: null, gifDuration: 1700),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "15 times", reps: "3x", gifSize: 140, gifDuration: 4000),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "∞ times", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Crunches", gif: "assets/images/crunches.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 4, dayDuration: "30-45 min", name: "Hanging\nLeg Raises", gif: "assets/images/hanging-leg-raises.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Medium-Width\nGrip Pull-ups", gif: "assets/images/pull-ups.gif", duration: "∞ times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Feet Elevated\nPush-Ups", gif: "assets/images/feet-elevated-push-ups.gif", duration: "∞ times", reps: "4x", gifSize: 120, gifDuration: 1600),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Bulgarian\nSquats", gif: "assets/images/bulgarian-squats.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Diamond\nPush-ups", gif: "assets/images/diamond-push-ups.gif", duration: "∞ times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Jump\nSquats", gif: "assets/images/jump-squats.gif", duration: "15 times", reps: "4x", gifSize: null, gifDuration: 1700),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "15 times", reps: "3x", gifSize: 140, gifDuration: 4000),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "∞ times", reps: "4x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Crunches", gif: "assets/images/crunches.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 5, dayDuration: "30-45 min", name: "Hanging\nLeg Raises", gif: "assets/images/hanging-leg-raises.gif", duration: "15 times", reps: "4x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Medium-Width\nGrip Pull-ups", gif: "assets/images/pull-ups.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Feet Elevated\nPush-Ups", gif: "assets/images/feet-elevated-push-ups.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1600),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Chin-ups", gif: "assets/images/pull-ups.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Bench\nDips", gif: "assets/images/bench-dips.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Bulgarian\nSquats", gif: "assets/images/bulgarian-squats.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Glute/Ham\nRaises", gif: "assets/images/glute-ham-raises.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Box\nJumps", gif: "assets/images/box-jumps.gif", duration: "10 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "15 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Bicycle\nCrunches", gif: "assets/images/bicycle-crunches.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 6, dayDuration: "30-45 min", name: "Lying\nLeg Raises", gif: "assets/images/lying-leg-raises.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Medium-Width\nGrip Pull-ups", gif: "assets/images/pull-ups.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Feet Elevated\nPush-Ups", gif: "assets/images/feet-elevated-push-ups.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1600),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Chin-ups", gif: "assets/images/pull-ups.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Bench\nDips", gif: "assets/images/bench-dips.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Bulgarian\nSquats", gif: "assets/images/bulgarian-squats.gif", duration: "15-20 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Glute/Ham\nRaises", gif: "assets/images/glute-ham-raises.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Box\nJumps", gif: "assets/images/box-jumps.gif", duration: "15 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "20 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Bicycle\nCrunches", gif: "assets/images/bicycle-crunches.gif", duration: "20 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 7, dayDuration: "30-45 min", name: "Lying\nLeg Raises", gif: "assets/images/lying-leg-raises.gif", duration: "20 times", reps: "3x", gifSize: 120, gifDuration: 3000),

  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Medium-Width\nGrip Pull-ups", gif: "assets/images/pull-ups.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Feet Elevated\nPush-Ups", gif: "assets/images/feet-elevated-push-ups.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1600),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Tricep\nDips", gif: "assets/images/tricep-dips.gif", duration: "∞ times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Biceps\nCurls", gif: "assets/images/biceps-curls.gif", duration: "∞ times", reps: "3x", gifSize: null, gifDuration: 3000),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Jump\nSquats", gif: "assets/images/jump-squats.gif", duration: "20 times", reps: "3x", gifSize: null, gifDuration: 1700),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Bulgarian\nSquats", gif: "assets/images/bulgarian-squats.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Single Leg\nCalf Raises", gif: "assets/images/single-leg-calf-raises.gif", duration: "15 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Sumo\nSquats", gif: "assets/images/sumo-squats.gif", duration: "20 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Pikes", gif: "assets/images/pikes.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1400),
  Workout(isRelax: false, week: 8, dayDuration: "30-45 min", name: "Bicycle\nCrunches", gif: "assets/images/bicycle-crunches.gif", duration: "20 times", reps: "3x", gifSize: 120, gifDuration: 1500),

];

List<Workout> workoutExtremePlan = [
  Workout(isRelax: false, day: 1, dayDuration: "90 min", name: "Deadlift", gif: "assets/images/deadlift.gif", duration: "3 times", reps: "4x", gifSize: null, gifDuration: 2000),
  Workout(isRelax: false, day: 1, dayDuration: "90 min", name: "Seated\nCable Row", gif: "assets/images/seated-cable-row.gif", duration: "8 times", reps: "3x", gifSize: 120, gifDuration: 2500),
  Workout(isRelax: false, day: 1, dayDuration: "90 min", name: "Lat\nPull Down", gif: "assets/images/lat-pull-down.gif", duration: "12 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 1, dayDuration: "90 min", name: "Push-ups", gif: "assets/images/push-ups.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 1700),
  Workout(isRelax: false, day: 1, dayDuration: "90 min", name: "Forward\nLunges", gif: "assets/images/forward-lunges.gif", duration: "15 times", reps: "3x", gifSize: 140, gifDuration: 4000),

  Workout(isRelax: false, day: 3, dayDuration: "90 min", name: "Seated\nShoulder Press", gif: "assets/images/seated-shoulder-press.gif", duration: "6 times", reps: "4x", gifSize: 140, gifDuration: 1500),
  Workout(isRelax: false, day: 3, dayDuration: "90 min", name: "Bench\nPress", gif: "assets/images/bench-press.gif", duration: "6 times", reps: "4x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, day: 3, dayDuration: "90 min", name: "Dumbbell\nLateral Raise", gif: "assets/images/dumbbell-lateral-raise.gif", duration: "12 times", reps: "3x", gifSize: 120, gifDuration: 2000),
  Workout(isRelax: false, day: 3, dayDuration: "90 min", name: "Fly", gif: "assets/images/machine-fly.gif", duration: "12 times", reps: "3x", gifSize: null, gifDuration: 1500),
  Workout(isRelax: false, day: 3, dayDuration: "90 min", name: "Dumbbell\nRow", gif: "assets/images/dumbbell-row.gif", duration: "8 times", reps: "3x", gifSize: 140, gifDuration: 1700),

  Workout(isRelax: false, day: 4, dayDuration: "90 min", name: "Barbell\nSquat", gif: "assets/images/barbell-squat.gif", duration: "3 times", reps: "4x", gifSize: 120, gifDuration: 1800),
  Workout(isRelax: false, day: 4, dayDuration: "90 min", name: "Leg\nPress", gif: "assets/images/leg-press.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1750),
  Workout(isRelax: false, day: 4, dayDuration: "90 min", name: "Dumbbell\nRomanian", gif: "assets/images/dumbbell-romanian.gif", duration: "8 times", reps: "3x", gifSize: null, gifDuration: 2000),
  Workout(isRelax: false, day: 4, dayDuration: "90 min", name: "Leg\nExtension", gif: "assets/images/leg-extension.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 2700),
  Workout(isRelax: false, day: 4, dayDuration: "90 min", name: "Lying\nLeg Curls", gif: "assets/images/lying-leg-curls.gif", duration: "15 times", reps: "3x", gifSize: 120, gifDuration: 2000),
  Workout(isRelax: false, day: 4, dayDuration: "90 min", name: "Calf\nRaise", gif: "assets/images/calf-raise.gif", duration: "20 times", reps: "4x", gifSize: 140, gifDuration: 1500),

  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Barbell\nSquat", gif: "assets/images/barbell-squat.gif", duration: "4 times", reps: "4x", gifSize: 120, gifDuration: 1800),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Dumbbell\nRow", gif: "assets/images/dumbbell-row.gif", duration: "4 times", reps: "4x", gifSize: 140, gifDuration: 1700),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Chest\nPress", gif: "assets/images/chest-press.gif", duration: "10 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Dumbbell\nLateral Raise", gif: "assets/images/dumbbell-lateral-raise.gif", duration: "12 times", reps: "3x", gifSize: 120, gifDuration: 2000),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Biceps\nCurls", gif: "assets/images/biceps-curls.gif", duration: "12 times", reps: "3x", gifSize: null, gifDuration: 3000),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Bench\nPress", gif: "assets/images/bench-press.gif", duration: "12 times", reps: "3x", gifSize: 120, gifDuration: 1500),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Preacher\nCurl", gif: "assets/images/preacher-curl.gif", duration: "12 times", reps: "3x", gifSize: 120, gifDuration: 2000),
  Workout(isRelax: false, day: 6, dayDuration: "90 min", name: "Diamond\nPush-ups", gif: "assets/images/diamond-push-ups.gif", duration: "12 times", reps: "3x", gifSize: 120, gifDuration: 1700),

];

List<WorkoutTips> workoutTips = [
  WorkoutTips(name: "Warm up and cool down", tips: "Walking is a fine way to warm up, stretching is an excellent way to cool down."),
  WorkoutTips(name: "Focus on form, not weight", tips: "Align your body correctly and move smoothly through each exercise. Poor form can prompt injuries and slow gains."),
  WorkoutTips(name: "Pay attention to your breathing", tips: "Exhale as you work against resistance by lifting, pushing, or pulling; inhale as you release."),
  WorkoutTips(name: "Stick with your routine", tips: "Exhale as you work against resistance by lifting, pushing, or pulling; inhale as you release."),
  WorkoutTips(name: "Stick with your routine", tips: "Working all the major muscles of your body two or three times a week is ideal."),
  WorkoutTips(name: "Give muscles time off", tips: "Strength training causes tiny tears in muscle tissue. These tears aren't harmful, but they are important: muscles grow stronger as the tears knit up. Always give your muscles at least 48 hours to recover before your next strength training session."),
];