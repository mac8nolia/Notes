# Notes

**Тестовое задание - приложение для создания пользовательских заметок** 


## Features 

  - Каждая заметка состоит из названия, непосредственно текста и фотографии (дефолтной, либо выбранной пользователем)

  - Возможно добавлять фотографии из галереи и снимки камеры

  - Заметки можно сохранять и удалять

  - Имеется поддержка тёмного режима 

  - Приложение поддерживает как портретную, так и альбомную ориентации

  - Приложение совместимо с iOS 12 и новее
  
  
  ## Technology Stack 

  - **Swift, UIKit** - здесь всё стандартно.  

  - Хранение данных - **CoreData**. Для отслеживания данных использован NSFetchedResultsController.
 
  - Архитектура - **MVC**. Данные и их обработка - в слое Model. Настройка и лэйаут сабвьюх вынесены в отдельные вью. У детальных вью (для создания и просмотра заметки) общий базовый класс с общим лэйаутом.

  - Адаптивность интерфейса решена с помощью **Autolayout** - вёрстка сделана кодом.
  
  - Сторонних фреймворков нет, в принципе всё решается нативно.

  - Адаптивность цветовых режимов решается с помощью системных цветов.
  
  ## Screenshots 

<img width="378" alt="img1" src="https://user-images.githubusercontent.com/77031399/112354585-e3a78600-8cdd-11eb-9e48-3887f8d32129.png">
<img width="733" alt="img2" src="https://user-images.githubusercontent.com/77031399/112354595-e6a27680-8cdd-11eb-9d0a-f2de087622b0.png">
<img width="381" alt="img3" src="https://user-images.githubusercontent.com/77031399/112354601-e7d3a380-8cdd-11eb-9993-2b37b336149b.png">
<img width="740" alt="img4" src="https://user-images.githubusercontent.com/77031399/112354602-e86c3a00-8cdd-11eb-914d-06114e183396.png">
<img width="381" alt="img5" src="https://user-images.githubusercontent.com/77031399/112354605-e904d080-8cdd-11eb-8696-49ed0036f110.png">
<img width="380" alt="img6" src="https://user-images.githubusercontent.com/77031399/112354606-e904d080-8cdd-11eb-891c-f0782140e784.png">
<img width="381" alt="img7" src="https://user-images.githubusercontent.com/77031399/112354608-e99d6700-8cdd-11eb-863c-01047c0ef117.png">
<img width="377" alt="img8" src="https://user-images.githubusercontent.com/77031399/112354610-ea35fd80-8cdd-11eb-89d6-0e4e0fde230a.png">
  
