# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.152 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.152"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.152/stella-0.9.152-aarch64-apple-darwin.tar.gz"
      sha256 "b29354214b819f618eaf9bdfb68304557f808d2585dedd6527453f06cadb4cbe"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.152/stella-0.9.152-x86_64-apple-darwin.tar.gz"
      sha256 "6e2b7c5bf81df5a481d009990ef48f1da94e2dbf93a6e4e429c8bbd199d479ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.152/stella-0.9.152-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ace26dafb51471a85629939d658881a518946c7794172981d60ca643907dddaa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.152/stella-0.9.152-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e8b73823b64fff7fb2809b1cf295c4896084c0ea03e5086b95994cb8093176d"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
