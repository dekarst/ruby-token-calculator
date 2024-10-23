require 'json'

# Load JSON data from files
def load_data
  users = JSON.parse(File.read('users.json'))
  companies = JSON.parse(File.read('companies.json'))
  [users, companies]
end

# Filter active users by company
def filter_active_users(users)
  users.select { |user| user['active_status'] }
end

# Group users by their company
def group_users_by_company(active_users)
  company_users = Hash.new { |hash, key| hash[key] = [] }
  active_users.each do |user|
    company_users[user['company_id']] << user
  end
  company_users
end

# Generate output for a specific company
def generate_company_output(company, users, top_up_amount)
  company_id = company['id']
  company_name = company['name']

  output_lines = []
  output_lines << "Company Id: #{company_id}"
  output_lines << "Company Name: #{company_name}"

  emailed_users = []
  not_emailed_users = []

  users.sort_by { |user| user['last_name'] }.each do |user|
    user_full_name = "#{user['last_name']}, #{user['first_name']}, #{user['email']}"
    previous_balance = user['tokens']
    new_balance = previous_balance + top_up_amount

    if user['email_status']
      emailed_users << "#{user_full_name}\n  Previous Token Balance, #{previous_balance}\n  New Token Balance #{new_balance}"
    else
      not_emailed_users << "#{user_full_name}\n  Previous Token Balance, #{previous_balance}\n  New Token Balance #{new_balance}"
    end
  end

  output_lines << "Users Emailed:"
  output_lines.concat(emailed_users)
  output_lines << "Users Not Emailed:"
  output_lines.concat(not_emailed_users)
  output_lines << "Total amount of top ups for #{company_name}: #{users.count * top_up_amount}"
  output_lines << ""

  output_lines
end

# Process data and generate output for all companies
def process_data(users, companies)
  active_users = filter_active_users(users)
  company_users = group_users_by_company(active_users)

  output_lines = []

  companies.sort_by { |company| company['id'] }.each do |company|
    company_id = company['id']
    top_up_amount = company['top_up']

    users_for_company = company_users[company_id]
    output_lines.concat(generate_company_output(company, users_for_company, top_up_amount))
  end

  # Write output to file
  File.write('output.txt', output_lines.join("\n"))
end

# Main execution
users, companies = load_data
process_data(users, companies)
