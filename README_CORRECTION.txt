E-GOSPEL APP — VERSION NETTOYÉE

Corrections effectuées :
- HeroSlide ne contient plus de paramètres title/subtitle/ctaLabel en double.
- Suppression des marqueurs de diff Git éventuels (@@, <<<<<<<, =======, >>>>>>>).
- featuredCategories affiche bien les 5 premières rubriques.
- La structure de l'application reste un portail mobile vers les pages existantes de e-gospel.com.

IMPORTANT — SHOREBIRD :
Le message « Shorebird requires code signing to be set up » est indépendant de la correction Dart ci-dessus.
La signature Android doit être configurée séparément dans l'environnement de build/Distribution avant une release Shorebird.
La clé de signature privée ne doit pas être incluse dans ce ZIP ni publiée sur GitHub.

Avant un build Flutter :
1. flutter pub get
2. flutter analyze
3. flutter build apk --debug   (pour un test local)
4. Pour Shorebird/release, configurer la signature Android dans l'outil de build utilisé.
