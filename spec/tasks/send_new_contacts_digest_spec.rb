require 'rake'
require 'spec_helper'
require 'rails_helper'

describe 'send_new_contacts_digest' do
  let(:hosting_relation) { double(:hosting_relation, all: all_hostings) }
  let(:all_hostings) { [contacted_hosting, uncontacted_hosting] }
  let(:contact) { double(:contact, visit: visit) }
  let(:contacted_host) { double(:contacted_host) }
  let(:contacted_hosting) { double(:contacted_hosting, host: contacted_host, contacts: contact_relation) }
  let(:empty_contact_relation) { double(:empty_contact_relation) }
  let(:contact_relation) { double(:contact_relation) }
  let(:uncontacted_hosting) { double(:uncontacted_hosting, contacts: empty_contact_relation) }
  let(:new_contacts) { [contact] }
  let(:visitor) { double(:visitor) }
  let(:visit) { double(:visit, user: visitor) }
  let(:expected_contact_data) do
    [
      {
        visitor: visitor,
        visit: visit,
        contact: contact
      }
    ]
  end

  before do
    BernieBNB::Application.load_tasks

    allow(Hosting)
      .to receive(:includes)
      .with(:host, contacts: [{ visit: [:user] }])
      .and_return(hosting_relation)

    allow(contact_relation)
      .to receive(:where)
      .and_return(new_contacts)

    allow(empty_contact_relation)
      .to receive(:where)
      .and_return([])
  end

  it 'should send the new contacts digest to hosts that have been contacted'do
    expect(UserMailer)
      .to receive(:new_contacts_digest)
      .with(contacted_hosting, contacted_host, expected_contact_data)
      .and_return(mailer)

    # expect(UserMailer)
    #   .not_to receive(:new_contacts_digest)
    #   .with(uncontacted_hosting, anything)

    # expect(mailer)
    #  .to receive(:deliver_now)

    Rake::Task['send_new_contacts_digest'].invoke
  end
end
