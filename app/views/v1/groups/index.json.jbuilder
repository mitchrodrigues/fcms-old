json.groups do |group_json| 
  group_json.array!(@groups) do |group|
    json.extract! group, :name
    json.permissions do |perm_json|
      perm_json.array!(group.group_permissions) do |gp|
        json.permission gp.permission.name
        json.description gp.permission.description
        json.level gp.level
      end
    end
  end
end