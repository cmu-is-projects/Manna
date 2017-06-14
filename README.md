# Manna
This is an application that allows case management and discussion for the Pittsburgh Allegheny Center Alliance Church (ACAC). Manna allows Pittsburgh ACAC's deacons submit, discuss, and vote on cases. This is a simple rails application built with [skeletoncss](getskeleton.com), a simple CSS framework.

This project was for an independent study done with Carnegie Mellon's Information Systems department, and the professor advising this project is [Professor Larry Heimann](https://github.com/profh). This project is intended for Pittsburgh ACAC use and educational use only.

As Prof H would say:
```
Qapla'
```

## Installation
Since this is a rails app, once you clone this repo all you need to do is run
```
bundle install
```

to install dependencies, and to set up the database:

```
rake db:drop db:create db:migrate db:seed
```
rake db:seed is important because that is how accounts are "created"
If you want to run the server, simply run
```
rails server
```

## Features
Here is a run down of the major features of Manna...
### Logging In
A user would typically log in as they would with any website. As of right now, accounts are "created" using the `db/seeds.rb`. An example would be like so:

```
User.create(first_name: 'Jason', last_name: 'Chen', email: 'jchen@gmail.com', password: 'meh', phone: '0000000000', role: 'admin', is_care_deacon: false)

```
It should be noted that this is not really safe, as the passwords are exposed. This was mainly done to move fast with development...

There are mainly 3 types of accounts:
- admin | `role` is listed as `admin`, and `is_care_deacon` set to `false`
  - can do everything
- financial deacon | `role` is listed as `deacon`, and `is_care_deacon` set to `false`
  - mainly votes/discusses on cases, but can also submit cases
- care deacon | `role` is listed as `deacon`, and `is_care_deacon` set to `true`
  - mainly submits cases, can only view own case

### Submitting Case/Adding Documents (Carrierwave)
When a financial deacon submits a case, there is an option to add document(s) to a case. [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) was used to make this happen, and the uploader falls under the Document model. Each document can have one attachment and each case can have multiple documents. Documents include: `jpg jpeg gif png pdf doc docx txt` and the whitelist can be found under `app/uploaders/AttachmentUploader`:
```
def extension_whitelist
  %w(jpg jpeg gif png pdf doc docx txt)
end
```
### Voting
For each case, the financial deacons can case a Vote: yes or no to approve or deny the case. The case only allows the user to vote once. The case displays a count for "Yes" votes and "No" votes, and when a user clicks on that section, a jquery dialog pops up to allow the user to case their vote.

Currently, the voting is handled with a validation for uniqueness to prevent multiple votes. If a user decides to change his/her vote, the admin would have to delete the vote and let the user re-vote.

### Commenting (Disqus)
[Disqus](https://disqus.com/) was used to allow for commenting on cases. Setup was quite simple, as a tutorial was followed from the [Disqus website](https://disqus.com/admin/install/platforms/universalcode/). Essentially, for each case that is shown, there is a section that allows for discussion.

Users would need to create a [Gravatar](http://en.gravatar.com/) account to be able to use Disqus.

### Searching Cases
A simple search bar was also implemented in this application. It currently can search for keywords in the following attributes for Cases `:subject`, `:description`, and `:client_name`. This search bar will exist on all pages, and is meant to allow users to look up Cases at any point.

## Testing
Coverage for all models besides `User.rb` is 100%. The user model has an authenticate method that I can't seem to test. Also, controller tests were minimal, as a lot of this project had to do with logging in.

Test helpers used were MiniTest and Simplecov.

## Design
Documents on design can be found under the `docs/` folder in the root directory. It should be noted that this project was made with the intention of it being mobile first, so most of the prototypes are mobile-only. With that, development was done on desktop, and stylized accordingly. It should also be noted that an [InVision application](https://invis.io/RUBKBJ6GJ) was also made.

Here you can find a list of things:
- `manna_mediumFi.ai` | medium fi prototype Adobe Illustrator file for mobile
- `manna_mediumFi_desktop.ai` | medium fi prototype Adobe Illustrator file for desktop
- `ERD_draft.pdf/ERD_draft.png` | this is the database ERD, but there might have been a small addition for Vote. I would refer to the current schema for the exact specs, but the ERD can still give a nice big picture visual
- `manna_mobile screens/` | rendered medium fi mock ups for reference

It should be noted that a good amount of the challenges for this project dealt with nested forms, AJAX, carrierwave, and more. The Case `show.html.erb` page will seem complex because it has to deal with an AJAX call to allow voting, and the case form has nested forms in it to allow for attaching documents.
## Next Steps
Here is a list of things that need to be done:
- Refine `ability.rb` or potentially add more rules
- Adding text-message notifications for cases that user (financial deacon) has not voted on
- Displaying clients (client "tab" on nav) and linking to a page that lists cases and documents relevant to the client
- Changing status of cases
- Create partials for sections of pages to reduce clutter
  - `home.html.erb`, Case `show.html.erb`, Case `index.html.erb`
- Allow deacons to "add" additional notes to each case (`:vote` attribute)
- Migrate DB to Postgres (if not deployed)

*The possibilities are endless...*

