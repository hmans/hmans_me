Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Some inline code: `puts("hi")` - amazing!

### Code Blocks

~~~ ruby
describe Flutterby::Node do
  let!(:folder_node) { Flutterby::Node.new("a_folder") }
  let!(:file_node)   { Flutterby::Node.new("file.txt", parent: folder_node) }
  let!(:page_node)   { Flutterby::Node.new("file.html.md", parent: folder_node) }

  context "HTML page nodes" do
    subject { page_node }
    it { is_expected.to be_page }
    it { is_expected.to be_file }
    it { is_expected.to_not be_folder }
  end

  context "file nodes" do
    subject { file_node }
    it { is_expected.to_not be_page }
    it { is_expected.to be_file }
    it { is_expected.to_not be_folder }
  end

  context "folder nodes" do
    subject { folder_node }
    it { is_expected.to_not be_page }
    it { is_expected.to_not be_file }
    it { is_expected.to be_folder }
  end
end
~~~
