# TriviaX 🧠

A production-ready Flutter quiz application with real-time trivia API integration and a full admin panel for custom quiz management.

---

## ✨ Features

- 🎮 **3 Difficulty Modes** — Easy, Medium, Hard (fetched from The Trivia API)
- 👑 **Admin Panel** — Create, edit, and delete custom quiz questions
- 🎯 **Custom Quiz** — Play admin-created questions with the same game engine
- ❤️ **Lives System** — 3 lives per game; game ends when lives reach 0
- 🏆 **Scoring** — +10 points per correct answer
- 🎊 **Confetti** — Celebration animation on high accuracy (≥60%)
- 🌙 **Dark / Light Mode** — Persisted locally via SharedPreferences
- 📱 **Responsive Design** — Glassmorphism UI with smooth animations
- 🔄 **Error Handling** — API timeout, retry button, empty states

---

## 🛠 Tech Stack

| Package | Purpose |
|---|---|
| `flutter_riverpod` | Quiz state, admin questions, score & lives |
| `get` | Navigation + Theme switching (GetX) |
| `http` | Trivia API integration |
| `go_router` | Routing (registered, available for deep-linking) |
| `lottie` | Lottie animation support |
| `confetti` | Celebration confetti on result screen |
| `shared_preferences` | Theme & custom quiz persistence |
| `google_fonts` | Poppins typography |
| `flutter_animate` | Micro-animations, page transitions, stagger effects |

---

## 🗂 Folder Structure

```
lib/
├── core/
│   ├── constants/        # AppConstants, ApiConstants
│   ├── theme/            # AppColors, AppTheme, ThemeController (GetX)
│   ├── utils/            # Extensions, helpers
│   └── services/         # StorageService (SharedPreferences)
│
├── features/
│   ├── quiz/
│   │   ├── data/         # QuizApiService (HTTP + error handling)
│   │   ├── models/       # QuestionModel, CustomQuestionModel
│   │   ├── repository/   # QuizRepository
│   │   ├── providers/    # quizProvider, quizGameProvider, scoreProvider, themeProvider
│   │   ├── screens/      # Splash, Home, Quiz, Result, Error, Loading
│   │   └── widgets/      # DifficultyCard, OptionTile, LivesWidget, ScoreWidget, ProgressBar, QuestionCard
│   │
│   └── admin/
│       ├── providers/    # CustomQuizNotifier (Riverpod StateNotifier + persistence)
│       ├── screens/      # AdminScreen, AddEditQuestionScreen, CustomQuizScreen
│       └── widgets/      # (Admin-specific reusable widgets)
│
├── shared/
│   ├── widgets/          # CustomButton, CustomTextField, AppLoadingWidget, AppErrorWidget
│   └── animations/       # FadeAnimation, ScaleAnimation
│
├── routes/
│   └── app_routes.dart   # All GetX routes
│
└── main.dart             # ProviderScope + GetMaterialApp + ThemeController binding
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.10.0`
- Dart SDK `^3.0.0`

### Installation

```bash
# Clone the repository
git clone <your-repo-url>

# Navigate to project
cd quiz_application

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🌐 API

**Base URL:** `https://the-trivia-api.com/api/questions`

**Endpoint:** `GET /questions?limit=10&difficulty={easy|medium|hard}`

**Response fields used:**
- `question` — The question text
- `correctAnswer` — The correct answer string
- `incorrectAnswers` — Array of 3 wrong answers

Answers are shuffled randomly each time a new question is loaded.

---

## 🎮 Game Logic

| Event | Effect |
|---|---|
| Correct answer | +10 points |
| Wrong answer | −1 life |
| Lives reach 0 | Game Over → Result screen |
| All questions answered | Quiz Complete → Result screen |
| Accuracy ≥ 60% | Confetti animation |

---

## 👑 Admin Panel

1. Open **Admin Panel** from the Home screen
2. Tap **+ Add Question** to create a new question
3. Fill in the question, 4 options, and select the correct answer
4. Questions are saved locally and persist across sessions
5. Tap the ✏️ edit icon to modify, 🗑️ delete icon to remove
6. Maximum 10 questions can be added

---

## 📱 Screens

| Screen | Description |
|---|---|
| Splash | Animated logo with bouncing dots |
| Home | Glassmorphism dashboard with difficulty cards |
| Quiz | Game screen with lives, score, progress, feedback |
| Result | Score breakdown with confetti (if passed) |
| Admin Panel | Question list with CRUD operations |
| Add/Edit Question | Form with option selector |
| Custom Quiz | Same quiz engine with admin questions |
| Error | Retry button with descriptive message |
| Loading | Standalone loading indicator |
