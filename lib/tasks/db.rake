namespace 'db' do
  desc 'Reset local development environment database to its defaults'
  task :reset_local do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
