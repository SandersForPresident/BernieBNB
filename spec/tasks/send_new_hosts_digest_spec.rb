require 'rake'
require 'spec_helper'
require 'rails_helper'

describe 'send_new_hosts_digest' do
  let(:hosting_relation) { [new_host] }
  let(:empty_hosting_relation) { [] }
  let(:all_hostings) { [contacted_hosting, uncontacted_hosting] }
  let(:new_host) { double(:new_host) }
  let(:new_hosting) { double(:new_hosting, host: new_host) }
  let(:mailer) { double(:mailer) }
  let(:visits_relation) { [visit_with_new_host, visit_without_new_host] }
  let(:visit_with_new_host) { double(:visit_with_new_host) }
  let(:visit_without_new_host) { double(:visit_without_new_host) }
  let(:expected_new_host_data) do
    [
      {
        hosting: new_hosting,
        host: host
      }
    ]
  end

  before do
    BernieBNB::Application.load_tasks

    allow(Visit)
      .to receive(:includes)
      .with(:user)
      .and_return(visits_relation)

    allow(empty_contact_relation)
      .to receive(:where)
      .and_return([])

    allow(mailer)
      .to receive(:deliver_now)
      .and_return(true)
  end

  it 'should send the new contacts digest only to hosts that have been contacted'do
    pending
    expect(UserMailer)
      .to receive(:new_contacts_digest)
      .with(contacted_hosting, contacted_host, expected_contact_data)
      .and_return(mailer)

    expect(UserMailer)
      .not_to receive(:new_contacts_digest)
      .with(uncontacted_hosting, anything)

    Rake::Task['send_new_contacts_digest'].invoke
  end
end

