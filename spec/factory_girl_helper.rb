def build_attributes(arg, *args)
  FactoryGirl.build(arg).attributes.delete_if do |k, v|
    skip = ["id", "created_at", "updated_at"]
    if !args.blank?
      skip += args
    end
    skip.member?(k)
  end
end