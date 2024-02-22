# School Data Hub

Software tool to handle school information flows in an effective, collaborative way.

### Origins

This software originated during the COVID-pandemic in our primary school "Hermannschule" in Stolberg (Germany). In order to keep track on attendance and quarantine statuses I developed a simple app to keep records in a collaborative way with a simple backend built with flask.

As I realized the time saving potential that brought handling this information digitally, I started to build a data model with information sets that we handle every day and cause long ways (walking across the school), cost time and organization resources, and leave long paper trails.

While learning more and more how programming works, I extended the model more and more...

### So what does it do?

The app takes exported information from the software provided by our Education ministry and uses it to build extended models in the backend to add our additional information.

### Data protection efforts

A singular approach that this app takes is the **transport of personal information through encrypted qr-codes**. It works like this:

1. When the client is installed, it needs school keys. Without them, it is useless.
2. As a security procedure, the school keys are kept securely as an unencrypted qr-code in the school's office. **Whoever wants to use the school data, has to come at least once.**
3. A user comes to the office and scans the school keys containing the URL of the server and encryption keys. These are stored in the device's secure storage.
4. Now the user can log in with their credentials. However, after the login process, there will still not be any school data to call /display.
5. Now, the user has to scan the pupils' credentials, tipically from the desktop version of the app installed in the administrative computer that has the education ministry software. With it a .txt file with pupils' data can be exported. The desktop version of this can import this file and create / update the data from the backend. This data is stored in the secure storage. With it - and with the encryption keys - the app can generate encrypted qr-codes that can be read with other clients to import the pupil identities. Only with this pupil data (and jwt tokens for authentication) are API calls possble.

#### But why so complicated?

Since I'm no expert in data security, this is the way I found to ensure that the pupils' personal data of the pupil isn't sent back and forth through the internet. In fact, this way the personal data only jumps through devices over encrypted qr-codes. As we are storing quite sensitive information, it is crucial that this information can't be related to a concrete pupil without proper authorization.

**Have you got a better idea? Pull requests welcome! :-)**

#### What else is encrypted?

For now, all stored images.

### Features already implemented

#### Attendance

- keep track of presence, minutes late, excused / unexcused, gone back home (e.g. for being sick), parents reached/not reached

#### Incidents

- keep track of school incidents and document them with a picture of a document (or whatever you want to photograph). Incidents could be an admonition, an accident report, or a parents meeting (anything you need to document).
  
#### Lists

- create private (user) or public check lists to keep track of whatever you need to keep track of (paid money for a day trip, signed form from the parents, ...), including a field for comments.
  
#### Authorizations

- authorizations are like lists, but an image can be attached, too. We use it for things that we need to keep a record from, like signed authorizations from the parents/guardians - for instance the authorization to take an avatar picture for this app.
  
#### Accounts

- In our school, we have an own currency. We use it as a reward system to motivate our pupils. With this currency, they can buy stuff in our own shop (like school t-shirts or buttons, but also pencils, erasers, or little games like yoyos and such).

#### Special information

- In case parents/guardians provide special information that everyone needs to know (like allergies, emergency medication, likelyhood of having an epilleptic stroke..), it can be called in a special list.

#### Individual learning support

Pupils have the right to get learning support according to their individual needs. Being an inclusive school, this also includes special needs. Our local school authority provides mandatory categories that we have to use to describe individual needs and formulate/follow specific educational goals. These have to be documented / kept record of, too. It is also essential, that this information is available to any colleague working with the pupil, and that all colleagues involved cooperate and share information.

- This app can work with any category tree - that means, you could use your own.

- Based on this tree, the app can document category statuses - as estimated by the responsible colleague for the pupil - and keep track of progress collaboratively.

- It also can document development goals, which are ideally formulated together with the pupil. 

#### Pupil profile

- All information about a pupil is bundled in a pupil profile view. Here you can call additional information like the parents' language proficiency in German (since over 90% of the families in our school do not speak German at home, this is relevant to us), siblings information, or information about afterschool care.

#### Filters

- Filters are incredibly useful when dealing with lists. There are general filters (like class, schoolyear) and specific filters for the different views implemented, as well as different ordering of the list elements according to different criteria depending on the view.

### Roadmap

The export of reports in a printable format (pdf) is crucial for us and because of that on top of the list.

There are also a couple of models in the backend that are not implemented in the client yet.

### TO-DO:

#### Design

- review widgets (I'm still not very good at it)
  
#### Functionality

- generally, improve code quality O:-)
- implement stream checking connection (don't know how to generate/handle streams yet)
- review state management (specially filters) across views
- subsitute hard coded enum filters with dynamic solution for other schools
- implement navigation?
- internationalization

#### Features

- pdf export feature (individual development plan, competence report)
- competence feature
- implement competence report, school semester
- UI to CRUD schooldays
- workbook feature
- book feature (library lending system)
- generate qr stickers as shortcuts for documenting features

### Thanks to the open source community

I have great admiration for everybody contributing to the frameworks and packages that I used for this project, and are deeply grateful for their generosity sharing their work. The more I learn about programming, the more I appreciate it. So thank you, open source community!