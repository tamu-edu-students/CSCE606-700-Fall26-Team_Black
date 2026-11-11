module MembershipHelpers
  # Member rows on the project page are expected to use dom_id(membership) as their id.
  def membership_row(member_name, project_name)
    membership = Membership.joins(:user, :project).find_by!(users: { name: member_name }, projects: { name: project_name })
    "##{ActionView::RecordIdentifier.dom_id(membership)}"
  end
end

World(MembershipHelpers)
