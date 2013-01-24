## Introduction

taxomatic helps you do your monthly tax declaration. It imports your invoices and bank statements, lets you flag expenses easily, and calculates the tax to be paid.

## Screenshots

### the tax declaration page

![image](https://raw.github.com/phillipoertel/taxomatic/master/doc/screenshots/tax_declaration.png)

### list of account statements (waiting to be flagged as expenses)

![image](https://raw.github.com/phillipoertel/taxomatic/master/doc/screenshots/statement_lines.png)

## Assumptions

1. you pay your taxes in Germany and have to do monthly advances payments for the sales tax.
1. you manage your bank accounts with the OS X application [Outbank](http://www.outbank.de/) (optional)
1. you use [Harvest](http://www.getharvest.com) to bill your clients  (optional)

\2. and 3. are optional, but they are the fun part! Of course you can also enter expenses and invoices by hand. I'm open accept pull requests for importers from other tools/services.

## Installation

* ensure you have Ruby 1.9.
* clone the repository, run bundle, and set up the database.
* copy config/taxomatic.yml.example to config/taxomatic.yml and configure it appropriately.

## Importing statements from Outbank

1. Before you start, ensure that all statement lines you are going to import have a category, and that this category is present in taxomatic (matching is done by name). You can also do this by trial-and-error as the lines that can't be imported will be skipped.
1. Export the statements of the desired Outbank accounts as CSV. When exporting, leave all settings at their default
2. save the file in data/outbank.csv. 
3. run `rake import:statements`

## Importing invoices from Harvest

1. Before you start, ensure that all clients of your invoices exist in taxomatic. the matching is done by the harvest_client id, You can also do this by trial-and-error as the lines that can't be imported will be skipped.
1. Configure the harvest client access data in app/models/invoice_import.rb.
3. run `rake import:invoices`

On the next export, you can export everything again, or just the new stuff. taxomatic will be careful not to import stuff twice.

## Pro tips

* run `rake backup` to dump the current database state to data/backups/. This task is run 
* run `rake import` to import both statements and invoices. This will also do a backup before importing.
* run taxomatic with the [Pow server](http://pow.cx) so it'll always be running in the background when you need it

## BIG DISCLAIMER

taxomatic may set your house on fire, delete all your bank accounts (including the money on it) and even kill a kitten in the process. Well, maybe it won't, but at least you have been warned.

taxomatic not security reviewed and has no login, so it shouldn't be run on the web. The tax calculations haven't been checked in depth. It may also be hard to understand/use by anyone who hasn't written it.

It is also not well tested everywhere, although I've been careful to test the recent parts of the model layer (data import).

It is (probably) also one of the oldest Ruby on Rails applications alive, being started at version 0.something. That's why you'll find plenty of code that would be written differently today.

I don't use the ESt (income tax) module anymore, don't use it without reviewing the code first.

## Todos

* write acceptance tests for a few variations of tax declarations.
* ensure that a StatementLine can only have one expenses (uniqueness of payments.expense_id)
* allow adapting the USt-rate per statement line directly in the USt interface
* fix row highlighter in /tax/ust > Ausgaben, it doesn't work