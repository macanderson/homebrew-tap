# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.75 / @SHA_*@ placeholders below with
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
  version "0.5.75"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.75/stella-0.5.75-aarch64-apple-darwin.tar.gz"
      sha256 "d5198370d84092b5ac29e938346db8cf325dc014951242e816c146a243681ed7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.75/stella-0.5.75-x86_64-apple-darwin.tar.gz"
      sha256 "4e09226f9a6a1e78fe763ed19e562722855af39aa13494075a56462efc48bc95"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.75/stella-0.5.75-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5021c19cfeab5b5d8709b444776ba28d5159ade39d875a329ca78d41efdafb2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.75/stella-0.5.75-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7297ff6acbb3dac03b94b72396c898be98116018b3cf1d43805fb4e87d74c023"
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
