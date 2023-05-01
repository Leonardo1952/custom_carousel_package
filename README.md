## Custom Carousel :carousel_horse:

Custom Carousel is a package that comes with the idea of making life easier for the developer who needs to add a carousel to his flutter project. We are currently at version: 0.0.1 

**Supported Platforms**

- Android
- IOS
- Web
- Desktop

**Installation**

In the pubspec.yaml file add:
`custom_carousel: ^0.0.1`

And in the files you need the package: `import 'package:custom_carousel/custom_carousel.dart';`

**Params**

```
CustomCarousel(
          items: items,
          transitionAutomatic: true,
          typeTransition: ManualTransition.line,
          autoTransitionTime: const Duration(seconds: 3),
          width: 500,
          height: 300,
          animationTransition: const Duration(milliseconds: 250),
    ),
```

**View**

![Gravação de tela de 01-05-2023 12_33_07](https://user-images.githubusercontent.com/53130191/235479852-e4b23828-212c-4fbd-813e-e0bb091d3aa5.gif)



**License**

- MIT
