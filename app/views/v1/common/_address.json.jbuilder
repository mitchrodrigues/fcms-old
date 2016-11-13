if address
  json.address do
    json.street1 address.street1
    json.street2 address.street2
    json.city    address.city
    json.state   address.state
    json.postal_code address.postal_code
  end
end