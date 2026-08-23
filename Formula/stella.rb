# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.173 / @SHA_*@ placeholders below with
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
  version "0.9.173"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.173/stella-0.9.173-aarch64-apple-darwin.tar.gz"
      sha256 "e8283aa97ded4f29042bf0627c03634a7599fdef130ca91eb05d61c6bc6b9a17"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.173/stella-0.9.173-x86_64-apple-darwin.tar.gz"
      sha256 "99e1b650e985cb46706b05af39593d8060793a009c7e50073cc778f6cd4d0223"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.173/stella-0.9.173-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2950df4facf7f579e721676321d24dca67b30d28d84377a0772e4dcf812a06d4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.173/stella-0.9.173-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b0f6e0636d49aa35d1f1fd60acbadfbf226c4814a0856d99ca029b57d2d7fa0"
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
