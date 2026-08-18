# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.102 / @SHA_*@ placeholders below with
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
  version "0.9.102"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.102/stella-0.9.102-aarch64-apple-darwin.tar.gz"
      sha256 "1d54a6cbe03002f48cb6fc17e9dd183e1700a23e8ec4abd0d75ba276049b6f9f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.102/stella-0.9.102-x86_64-apple-darwin.tar.gz"
      sha256 "5f5f0ee199b028c0213411f3fb6c6041892d0ad0d136f36fef34c1c1d7e6434d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.102/stella-0.9.102-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cd1735184a2bcc96e0c9d11ff16cb5b8df090d888a0401454f84a911e26a42f1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.102/stella-0.9.102-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83c4543465407a548f795157c7191f0291af08471c1e45b2a6d825c97bdfe8c7"
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
