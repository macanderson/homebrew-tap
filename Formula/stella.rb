# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.351 / @SHA_*@ placeholders below with
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
  version "0.9.351"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.351/stella-0.9.351-aarch64-apple-darwin.tar.gz"
      sha256 "7d7fe6cf2d786b286da1c1969165e5a46157b8e08f9df4ffa137d58223d4bc9f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.351/stella-0.9.351-x86_64-apple-darwin.tar.gz"
      sha256 "fe94e45c4158d96bf94db1ca744ced2cab9729adad6c81e100653589b4db7081"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.351/stella-0.9.351-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa76d1abdb049d8f3be022e8f18b9011d3c5dc9ca645f398ba07cf9551ddd106"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.351/stella-0.9.351-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c58d5df71aefe32bebbd1fb78279e8881b4909ec7ad14dfcddb7b0ed88c975a"
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
