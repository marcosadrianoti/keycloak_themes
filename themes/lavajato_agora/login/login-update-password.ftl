<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>

<div class="flex flex-col min-h-screen items-center justify-center mb-0 font-Jakarta font-semibold text-base">
    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
        <#if section = "header">
            <span class="text-xl font-semibold">
                ${msg("updatePasswordTitle")}
            </span>
        <#elseif section = "form">
            <form
                id="kc-passwd-update-form"
                class="${properties.kcFormClass!} mb-0"
                action="${url.loginAction}"
                method="post"
            >
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label
                            for="password-new"
                            class="${properties.kcLabelClass!} text-sm font-medium text-black mt-4"
                        >
                            ${msg("passwordNew")}
                        </label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="${properties.kcInputGroup!}">
                            <input
                                type="text"
                                id="password-new"
                                name="password-new"
                                class="font-Jakarta rounded-md border border-gray-200 bg-white py-2 px-3 h-9"
                                autofocus autocomplete="new-password"
                                aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                            />
                            <#--  <button
                                class="${properties.kcFormPasswordVisibilityButtonClass!}"
                                type="button"
                                aria-label="${msg('showPassword')}"
                                aria-controls="password-new"
                                data-password-toggle
                                data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}"
                                data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                data-label-show="${msg('showPassword')}"
                                data-label-hide="${msg('hidePassword')}"
                            >
                                <i
                                    class="${properties.kcFormPasswordVisibilityIconShow!}"
                                    aria-hidden="true"
                                >
                                </i>
                            </button>  -->
                        </div>

                        <#if messagesPerField.existsError('password')>
                            <span
                                id="input-error-password"
                                class="${properties.kcInputErrorMessageClass!}"
                                aria-live="polite"
                            >
                                ${kcSanitize(messagesPerField.get('password'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label
                            for="password-confirm"
                            class="${properties.kcLabelClass!} text-sm font-medium text-black"
                        >
                            ${msg("passwordConfirm")}
                        </label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="${properties.kcInputGroup!}">
                            <input
                                type="text"
                                id="password-confirm"
                                name="password-confirm"
                                class="font-Jakarta rounded-md border border-gray-200 bg-white py-2 px-3 h-9"
                                autocomplete="new-password"
                                aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                            />
                            <#--  <button
                                class="${properties.kcFormPasswordVisibilityButtonClass!}"
                                type="button"
                                aria-label="${msg('showPassword')}"
                                aria-controls="password-confirm"
                                data-password-toggle
                                data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}"
                                data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                data-label-show="${msg('showPassword')}"
                                data-label-hide="${msg('hidePassword')}">
                                <i
                                    class="${properties.kcFormPasswordVisibilityIconShow!}"
                                    aria-hidden="true"
                                >
                                </i>
                            </button>  -->
                        </div>

                        <#if messagesPerField.existsError('password-confirm')>
                            <span
                                id="input-error-password-confirm"
                                class="${properties.kcInputErrorMessageClass!}"
                                aria-live="polite"
                            >
                                ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                            </span>
                        </#if>

                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!} mb-0">
                    <#--  <@passwordCommons.logoutOtherSessions/>  -->

                    <div
                        id="mt-0"
                        class="${properties.kcFormButtonsClass!}"
                    >
                        <#if isAppInitiatedAction??>
                            <input
                            
                                class="bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                                type="submit"
                                value="${msg("doSubmit")}"
                            />
                            <button
                                class="bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                                type="submit"
                                name="cancel-aia"
                                value="true"
                            />
                                ${msg("doCancel")}
                            </button>
                        <#else>
                            <input
                                class="bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                                type="submit"
                                value="${msg("doSubmit")}"
                            />
                        </#if>
                    </div>
                </div>
            </form>
            <script
                type="module"
                src="${url.resourcesPath}/js/passwordVisibility.js"
            >
            </script>
        </#if>
    </@layout.registrationLayout>
</div>
