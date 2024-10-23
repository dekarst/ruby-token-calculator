# User/Company Token Calculator

This Ruby script calculates user and company data from JSON files to calculate token balances based on email status and company top-ups. The results are outputted to a text file.

## Features

- Loads user and company data from JSON files.
- Any user that belongs to a company in the companies list and is active needs to get a token top up of the specified amount in the companies top up field.
- If the users company email status is true indicate in the output that the user was sent an email ( don't actually send any emails).
  However, if the user has an email status of false, don't send the email regardless of the company's email status.
- Companies should be ordered by company id.
- Users should be ordered alphabetically by last name.
- Outputs a detailed report of users and their token balances to a text file.

## Prerequisites

- Ruby v2.5+

## Installation

Clone the repository:
   ```bash
   git clone https://github.com/dekarst/ruby-token-calculator.git
   cd ruby-token-calculator
   ```

## Usage

Run the script in your terminal:

```bash
ruby challenge.rb
```

Ensure the `user.json` and `companies.json` files are present in the same directory as the script.

## Input Files

The script expects two JSON files with the following structures:

### `user.json`
```json
[
   {
      "id": 1,
      "first_name": "Tanya",
      "last_name": "Nichols",
      "email": "tanya.nichols@test.com",
      "company_id": 2,
      "email_status": true,
      "active_status": false,
      "tokens": 23
   },
   ...
]
```

### `companies.json`
```json
[
   {
      "id": 1,
      "name": "Blue Cat Inc.",
      "top_up": 71,
      "email_status": false
   },
   ...
]
```

## Output

The output will be written to a file named `output.txt`, structured as follows:

```
   Company Id: 1
   Company Name: Blue Cat Inc.
   Users Emailed:
   Users Not Emailed:
      Carr, Genesis, genesis.carr@demo.com
         Previous Token Balance, 71
         New Token Balance 142
      Lynch, Eileen, eileen.lynch@fake.com
         Previous Token Balance, 40
         New Token Balance 111
      Total amount of top ups for Blue Cat Inc.: 142
   ...
```

## Error Handling

The script includes error handling for:
- Missing JSON files
- JSON parsing errors
